import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:fireship/fireship.dart';

/// Chat
///
class ChatService {
  static late final ChatService? _instance;
  static ChatService get instance => _instance ??= ChatService._();

  static String? myUid = UserService.instance.user?.uid;

  ChatService._() {
    print('--> ChatService._()');
  }

  init() {
    print('--> ChatService.init()');
  }

  /// Firebase Realtime Database Chat Functions
  ///
  ///

  /// Firebase Realtime Database instance
  FirebaseDatabase get rtdb => FirebaseDatabase.instance;
  DatabaseReference get roomsRef => rtdb.ref().child('chat-rooms');
  DatabaseReference get messageseRef => rtdb.ref().child('chat-messages');
  DatabaseReference get joinsRef => rtdb.ref().child('chat-joins');
  DatabaseReference roomRef(String roomId) => roomsRef.child(roomId);
  DatabaseReference joinRef(String myUid, String roomId) => joinsRef.child(myUid).child(roomId);
  DatabaseReference messageRef({required String roomId}) =>
      rtdb.ref().child('chat-messages').child(roomId);

  // This is used to update the last message in the chat room list per user in /chat-joins
  String joinPath(String roomId, String uid) => '/chat-joins/$uid/$roomId';
  String _getMessagesPath(String roomId) => '/chat-messages/$roomId';

  /// [roomUserRef] is the reference to the users node under the group chat room. Ex) /chat-rooms/{roomId}/users/{my-uid}
  DatabaseReference roomUserRef(String roomId, String uid) =>
      rtdb.ref().child('chat-rooms/$roomId/users/$uid');

  /// 각 채팅방 마다 -1을 해서 order 한다.
  ///
  /// 더 확실히 하기 위해서는 order 를 저장 할 때, 이전 order 의 -1 로 하고, 저장이 된 후, createAt 의 -1 을 해 버린다.
  final Map<String, int> roomMessageOrder = {};

  /// Set the current room.
  ChatRoomModel? _currentRoom;
  ChatRoomModel get currentRoom => _currentRoom!;
  setCurrentRoom(ChatRoomModel room) => _currentRoom = room;

  /// 채팅 메시지 전송
  ///
  ///
  Future<void> sendMessage({
    String? text,
    String? url,
  }) async {
    if ((url == null || url.isEmpty) && (text == null || text.isEmpty)) return;

    if (UserService.instance.user?.isDisabled == true) {
      throw Exception('you-are-disabled');
    }

    ///
    roomMessageOrder[currentRoom.id] = (roomMessageOrder[currentRoom.id] ?? 0) - 1;

    /// 참고, 실제 메시지를 보내기 전에, 채팅방 자체를 먼저 업데이트 해 버린다.
    ///
    /// 상황 발생, A 가 B 가 모두 채팅방에 들어가 있는 상태에서
    /// A 가 B 에게 채팅 메시지를 보내면, 그 즉시 B 의 채팅방 목록이 업데이트되고,
    /// B 의 채팅방의 newMessage 가 0 으로 된다.
    /// 그리고, 나서 updateJoin() 을 하면, B 의 채팅 메시지가 1이 되는 것이다.
    /// 즉, 0이 되어야하는데 1이 되는 상황이 발생한다. 그래서, updateJoin() 이 먼저 호출되어야 한다.
    Map<String, dynamic> multiUpdateData = getMultiUpdateJoinMap(text: text, url: url);

    /// Save chat message under `/chat-messages`.
    multiUpdateData[
        '${_getMessagesPath(currentRoom.id)}/${DateTime.now().millisecondsSinceEpoch}_$myUid'] = {
      'uid': myUid,
      if (text != null) 'text': text,
      if (url != null) 'url': url,
      'order': roomMessageOrder[currentRoom.id],
      'createdAt': ServerValue.timestamp,
    };

    // See reference for the multi-path update.
    // Reference: https://firebase.google.com/docs/database/flutter/read-and-write#updating_or_deleting_data
    await rtdb.ref().update(multiUpdateData);

    // if it's 1:1 chat, then update other user's name and photo under the my chat room info.
    if (currentRoom.isSingleChat) {
      final otherUid = currentRoom.otherUserUid!;
      final other = await UserModel.get(otherUid);
      joinRef(myUid!, singleChatRoomId(otherUid)).update({
        'name': other?.displayName,
        'photoUrl': other?.photoUrl,
      });
    }
  }

  Map<String, dynamic> getMultiUpdateJoinMap({
    String? text,
    String? url,
  }) {
    Map<String, dynamic> multiUpdateData = {};
    final epoch = DateTime.now().millisecondsSinceEpoch;

    for (final e in currentRoom.users?.entries.toList() ?? []) {
      final uid = e.key;
      multiUpdateData[joinPath(currentRoom.id, uid)] = _lastMessage(
        text: text,
        url: url,
        newMessage: uid == myUid ? null : ServerValue.increment(1),
        order: uid == myUid ? -epoch : -int.parse("1$epoch"),
      );
    }

    return multiUpdateData;
  }

  /// see rchat.md
  ///
  /// [receiverUid] is the one who will receive the message.
  // static Future<Map<String, dynamic>> _lastMessage({
  Map<String, dynamic> _lastMessage({
    String? text,
    String? url,
    required dynamic newMessage,
    required int order,
  }) {
    // chat room info
    final data = {
      'name': currentRoom.isSingleChat
          ? UserService.instance.user?.displayName
          : (currentRoom.name ?? ''),
      'photoUrl': UserService.instance.user?.photoUrl,
      'text': text,
      'url': url,
      'updatedAt': ServerValue.timestamp,
      'newMessage': newMessage,
      'isGroupChat': currentRoom.isGroupChat,
      'isOpenGroupChat': currentRoom.isOpenGroupChat,
      //
      'order': order,
    };
    return data;
  }

  /// 채팅방 나가기
  ///
  /// 상대방의 채팅방 목록에서는 삭제하지 않고, 나의 채팅방 목록에서만 삭제한다.
  /// 즉, 상대방은 모르게 한다.
  ///
  /// For 1:1 chat, just remove the chat room node from /chat-rooms/{myUid}/{otherUid}
  /// For group chat, remove the chat room node from /chat-rooms/{myUid}/{groupChatId}
  ///   and remove my uid from /chat-rooms/{gropChatId}/users/{myUid}
  leaveRoom({
    required ChatRoomModel room,
  }) {
    joinRef(myUid!, room.id).remove();
    roomUserRef(room.id, myUid!).remove();

    /// 채팅 방에 인원이 더 이상 없으면, 채팅 방을 삭제한다.
    room.deleteIfNoUsers();
  }

  /// 채팅방의 메시지 순서(order)를 담고 있는 [ChatService.instance.roomMessageOrder] 를 초기화 한다.
  resetRoomMessageOrder({required String roomId, required int? order}) async {
    if (ChatService.instance.roomMessageOrder[roomId] == null) {
      ChatService.instance.roomMessageOrder[roomId] = 0;
    }
    if (order != null && order < ChatService.instance.roomMessageOrder[roomId]!) {
      ChatService.instance.roomMessageOrder[roomId] = order;
    }
  }

  /// 채팅방의 메시지 순서(order)를 가져온다.
  /// 만약, [ChatService.instance.roomMessageOrder] 에 값이 없으면 0을 리턴한다.
  static int getRoomMessageOrder(String messageRoomId) {
    return ChatService.instance.roomMessageOrder[messageRoomId] ?? 0;
  }

  /// 채팅방 정보 `/chat-rooms/$uid/$otherUid` 에서 newMessage 를 0 으로 초기화 한다.
  ///
  /// 특히, 내가 채팅방에 들어가 갈 때, 또는 내가 채팅방에 들어가 있는데, 새로운 메시지가 전달되어져 오는 경우,
  /// 이 함수가 호출되어 그 채팅방의 새 메시지 수를 0으로 초기화 할 때 사용한다.
  ///
  /// setting the order into -updatedAt (w/out the "1")
  /// this is used to order by unread/read messages then by updatedAt
  /// w/out the "1" it means it has been read.
  Future<void> resetMyRoomNewMessage({
    required ChatRoomModel room,
    int? order,
  }) async {
    final myJoinRef = joinRef(myUid!, room.id);
    // the problem is when this is too fast
    myJoinRef.update({
      'newMessage': null,
      'order': order ?? -int.parse('${room.updatedAt ?? room.createdAt ?? 0}'),
    });

    // wait for 1 second before updating the order

    // .then((value) {
    //   myJoinRef.child('updatedAt').get().then((updatedAt) {
    //     myJoinRef.update({'order': -int.parse('${(updatedAt.value ?? "0") as int}')});
    //   });
    // });
    // print('--> resetRoomNewMessage: $roomId');
  }

  /// 누군가 채팅을 해서, 새로운 메시지가 전달되어져 왔는지 판단하는 함수이다.
  ///
  /// 채팅방 목록을 하는 [RChatMessageList] 에서 사용 할 수 있으며, 새로운 메시지가 전달되었으면, newMessage 를
  /// 0 으로 저장해야 할 지, 판단하는 함수이다.
  ///
  /// [messageRoomId] 는 채팅 메시지를 저장하는 노드 ID(채팅방 ID가 아님),
  ///
  /// [snapshot] 은 채팅방 안에서, 페이지 단위로 채팅을 로딩 할 때, 그 채팅 노드를 담고 있는
  /// [FirebaseDatabaseQueryBuilder] 의 snapshot 이다.
  /// 처음 채팅방 접속 또는 채팅방을 위로 스크롤 할 때, 또는 누군가 새로운 채팅을 할 때, 새로운 채팅 목록 정보를 가져와서
  /// 화면에 보여줄 때, 이 함수가 호출된다. 이 때, [snapshot] 이 그 채팅 메시지 목록을 가지고 있다.
  ///
  ///
  /// 이 함수는, 누군가 채팅을 해서 (내가 채팅한 것이 아닌), 새로운 메시가 전달되었다면 true 를 리턴한다. 화면 스크롤이나, 처음 채팅방 접속해서
  /// 채팅 메시지를 가져오는 경우에는 false 를 리턴한다.
  ///
  /// 처음 로딩(첫 페이지)하거나, Hot reload 를 하거나, 채팅방을 위로 스크롤 업 해서 이전 데이터 목록을 가져오는 경우에는
  /// false 를 리턴한다.
  ///
  /// 채팅방에 들어가 있는 상태에서 새로운 메시지를 받으면, "newMessage: 를 0 으로 초기화 하기 위해서이다. 즉,
  /// 채팅 메시지를 읽음으로 표시하기 위해서이다.
  ///
  /// 문제, 앱을 처음 실행하면, [chatRoomMessgaeOrder] 에는 아무런 값이 없다. 이 때, 새로운 메시지가 있는
  /// 채팅방으로 접속을 하면, `if (currentMessageOrder == 0 ) return fales` 에 의해서 항상 false 가
  /// 리턴된다. 그래서, 처음 채팅방에 진입을 할 때에는 [snapshot.isFetching] 을 통해서 newMessage 를 초기화
  /// 해야 한다.
  bool isLoadingNewMessage(String messageRoomId, FirebaseQueryBuilderSnapshot snapshot) {
    if (snapshot.docs.isEmpty) return false;

    final lastMessage = ChatMessageModel.fromSnapshot(snapshot.docs.first);
    final lastMessageOrder = lastMessage.order as int;

    final currentMessageOrder = getRoomMessageOrder(messageRoomId);

    /// 이전에 로드된 채팅 메시지가 없는가? 누군가 채팅을 한 것이 아니라, 채팅방에 접속해서, 처음 로드된 것이므로 false 를 리턴한다.
    ///
    if (currentMessageOrder == 0) {
      return false;
    }

    /// 이전에 로드된 채팅 메시지가 있는가?
    /// 그렇다면 이전에 로드된 채팅 메시지의 order 와 현재 로드된 채팅 메시지의 order 를 비교한다.
    /// 만약 이전에 로드된 채팅 메시지의 order 가 현재 로드된 채팅 메시지의 order 보다 크다면,
    /// 누군가 채팅을 해서 새로운 메시지가 있다는 것이다.
    ///
    /// This return false when I am the one who sent message.
    if (currentMessageOrder > lastMessageOrder) {
      return true;
    }

    /// 이전에 로드된 채팅 메시지가 있지만, 새로운 채팅 메시지를 받지 않았다면, false 를 리턴한다.
    /// 위로 스크롤 하는 경우, 이 메시지가 발생 할 수 있다.
    return false;
  }

  /// For group chat, the user uid is added to /chat-rooms/{groupChatId}/users/{[uid]: true}
  /// For 1:1 chat, create a chat room info under my chat room list only. Not the other user's.
  ///
  /// Note, it's not that harmful to set the same uid to true over again and if it happens
  /// only one time when the user enters the chat room.
  ///
  ///
  ///
  Future joinRoom() async {
    final room = currentRoom;
    final otherUserUid = room.otherUserUid;

    if (room.users?.containsKey(myUid) != true) {
      dog('ChatService.instance.joinRoom: Not joined, yet. Joing now ...');
      // await set("${room.path}/users/$myUid", true);
      await room.ref.child('users').child(myUid!).set(true);
    }
    if (room.isSingleChat) {
      if (room.users?.containsKey(otherUserUid) != true) {
        await room.ref.child('users').child(otherUserUid!).set(true);
      }
    }

    final data = {
      'name': room.isGroupChat ? room.name : '',
      'isGroupChat': room.isGroupChat,
      'isOpenGroupChat': room.isOpenGroupChat,
      'newMessage': null,
    };

    /// 1:1 채팅방의 경우, 상대방의 이름을 저장한다.
    if (otherUserUid != null) {
      final user = await UserModel.get(otherUserUid);
      data['name'] = user?.displayName;
    }

    // set order into -updatedAt (w/out "1")
    // it is important to know that updatedAt must not be updated
    // before this.
    data['order'] = -int.parse('${currentRoom.updatedAt ?? currentRoom.createdAt ?? 0}');
    await joinsRef.child(myUid!).child(room.id).update(data);
  }

  static Future createRoom({
    required String name,
    required bool isGroupChat,
    required bool isOpenGroupChat,
  }) async {
    final room = await ChatRoomModel.create(
      name: name,
      isGroupChat: isGroupChat,
      isOpenGroupChat: isOpenGroupChat,
    );

    return room;
  }
} // EO RChat