# 채팅

**할일: 본 문서는 easychat 로 이동되어야 합니다.**


- [채팅](#채팅)
  - [TODO](#todo)
  - [참고](#참고)
  - [Chat 데이터베이스 구조](#chat-데이터베이스-구조)
    - [Chat Rooms 구조](#chat-rooms-구조)
    - [Chat Messages 구조](#chat-messages-구조)
    - [채팅방 설정](#채팅방-설정)
      - [채팅방 설정과 비밀번호](#채팅방-설정과-비밀번호)
  - [1:1 채팅방에 상대방의 사진와 이름이 나오는 로직](#11-채팅방에-상대방의-사진와-이름이-나오는-로직)
  - [코딩 기법](#코딩-기법)
    - [채팅 방에서 사용자의 전체 채팅 메시지 가져오기](#채팅-방에서-사용자의-전체-채팅-메시지-가져오기)
    - [채팅방에서 로그인한 사용자의 메시지 한 개만 가져오기](#채팅방에서-로그인한-사용자의-메시지-한-개만-가져오기)
    - [ChatModel에서 ChatRoom 가져오기](#chatmodel에서-chatroom-가져오기)
    - [Order](#order)
    - [채팅방 만들기](#채팅방-만들기)
    - [채팅방 입장](#채팅방-입장)
    - [Updating Chat Room](#updating-chat-room)
    - [Sending Chat Messages](#sending-chat-messages)
    - [Getting Chat Messages in a Room](#getting-chat-messages-in-a-room)
    - [Opening the Settings for the Chat Room](#opening-the-settings-for-the-chat-room)
    - [채팅방 목록 (Chat Room List)](#채팅방-목록-chat-room-list)
      - [DefaultChatRoomListView Widget](#defaultchatroomlistview-widget)
      - [ChatRoomListView](#chatroomlistview)
      - [오픈 챗 목록하기](#오픈-챗-목록하기)
      - [직접 데이터베이스에 쿼리하여 채팅방 목록하기](#직접-데이터베이스에-쿼리하여-채팅방-목록하기)
        - [Chat Rooms not Necessarily Joined by the Currently Logged in User (roomsRef)](#chat-rooms-not-necessarily-joined-by-the-currently-logged-in-user-roomsref)
  - [Toggling Notifications](#toggling-notifications)
  - [Group Chat Room](#group-chat-room)
    - [Creating a Group Chat](#creating-a-group-chat)
    - [사용자 초대](#사용자-초대)
    - [Group Chat Members](#group-chat-members)
    - [Removing a Group Chat Member](#removing-a-group-chat-member)
  - [Management](#management)
  - [채팅 메시지 전송 콜백 - beforeMessageSent, afterMessageSent](#채팅-메시지-전송-콜백---beforemessagesent-aftermessagesent)
  - [채팅 방 생성 다이얼로그 UI 변경](#채팅-방-생성-다이얼로그-ui-변경)
  - [채팅방 입장했는데 로그인을 하지 않은 경우](#채팅방-입장했는데-로그인을-하지-않은-경우)
  - [채팅 메시지 수 표시](#채팅-메시지-수-표시)
  - [채팅 메시지 삭제](#채팅-메시지-삭제)
  - [그룹 채팅 사용자 차단](#그룹-채팅-사용자-차단)
  - [성별 설정](#성별-설정)
  - [알려진 문제](#알려진-문제)


## TODO

- 1:1 채팅방의 경우, `chat-rooms` 에서 설정하는 것이 아니라, `chat-join` 에서 설정을 해야 한다.
- 그룹 채팅방의 경우, 개별 설정이 필요하다면, `chat-join` 에서 추가 설정을 해야 한다. 예를 들어, 채팅방 이름 변경, 채팅방 목록에서 우선 순위 표시 등.

## 참고

- 이론적으로 동시에 채팅방 여러개에 접속 할 수 있다. 하지만, 그럴 필요가 없어서 아직 테스트는 못했다.
- 사용자가 채팅방에 들어 있는 상태에서 이름을 변경하면, 바로 적용이 안되고, 앱을 종료하고 다시 실행해야 변경 적용이 된다. 이것은 버그로 보이며, [git issue](https://github.com/users/thruthesky/projects/9/views/41?pane=issue&itemId=64528981) 에 보고되어져 있다.

- 채팅 기능에서 수정 기능은 지원하지 않는다. 채팅 메시지는 법적 증거로 쓰일 수 있으며, 나중에 수정이 되면 큰 문제가 될 수 있다.


## Chat 데이터베이스 구조

- `/chat-rooms` 채팅 방 정보를 저장하는 경로.
- `/chat-messages` 채팅 메시지를 저장하는 경로
- `/chat-joins` 채팅 방에 참여한 사용자들에게 채팅방 정보를 장하는 경로. 예를 들어, 사용자별 읽지 않은 (새로운) 메시지 수를 표시하는 데 사용. 참고로, `/chat-rooms` 과 `/chat-joins` 둘 모두 `ChatRoom` 을 사용해서 modeling 한다.
- `noOfUsers` is updated in `/chat-rooms` when a new user joins or leaves a group chat room,
    - and is updated in `/chat-joins` when a chat message is sent.
- When sending a chat message, if the text contains a URL, information for previewing the URL is extracted. The appropriate values are stored in the following fields below the message:
    - `previewUrl` - URL
    - `previewTitle` - Title
    - `previewDescription` - Description
    - `previewImageUrl` - Image

### Chat Rooms 구조

- `master` 필드는 그룹 채팅 일 경우만 저장된다. 그룹 채팅 방에서 본인이 master 이면 채팅방 설정을 하면 된다.

- `blocks` - 관리자가 채팅방의 블럭 리스트를 관리한다. 여기에 추가된 사용자는 채팅방에 입장을 할 수 없다. 또한 자동으로 채팅방에서 튕겨나가도록 한다. (**TODO: 2024-02-22 현재 기능 구현되지 않음.**)


- `open` 옵션은 단순히 오픈 채팅방에 목록되거나 채팅방이 검색된다는 뜻이다. `open` 이 false 로 지정되어도, 사람들은 여전히 (그냥) 입장을 할 수 있다.


- `hasPassword` 는 채팅방에 비밀번호가 있으면 `true` 로 지정된다.

### Chat Messages 구조

- 채팅 메시지는 `/chat-messages/<room-id>/<id>` 에 저장된다.

- `uid` 메시지 전송한 사용자의 uid
- `createdAt` 메시지 전송한 시간
- `order` 메시지 목록 순서
- `text` 텍스트를 전송한 경우.
- `url` 사진 URL. 사진을 전송한 경우.
- `deleted` 채팅 메시지가 삭제되면 true 값이 저장되고, text, url, url preview 등의 값이 모두 삭제된다.


### 채팅방 설정


- 일반적으로 채팅방 이름, 설명, 사진 등의 기본 정보는 /chat-rooms 에 저장된다. 하지만, 사용자에게 공개되면 안되는 비밀스러운 정보는 /settings/chat-rooms 에 저장된다.

#### 채팅방 설정과 비밀번호

- `/settings/chat-rooms/<room-id>/password` 필드는 채팅방의 비밀번호를 가지며, 이 값이 null, undefined, empty 가 아니라, 값이 있으면 사용자는 cloud functions 함수 호출을 통해서만 join 할 수 있다.

- `/settings/chat-rooms/<room-id>/password` 필드는 채팅방의 master 만 읽고 쓸 수 있도록 security rules 에 지정되어져 있다.
  - 그래서 일반 사용자는 접근 권한이 없어 비밀번호가 있는지 조차 알 수 없는데, 이것이 프로그램 로직을 어렵게 한다.
    - 그래서 프로그램 로직을 쉽게하기 위해서 `/settings/chat-rooms/<room-id>/password` 에 값을 설정 할 때에는 채팅방의 `hasPassword` 에 true 를 저장하고 비밀번호가 삭제되면 false 를 지정한다. 즉, 이 두 값은 쌍으로 설정된다.
    참고로, 비밀번호 설정을 백엔드 함수를 통해서 이 두 쌍의 값이 같이 움직이도록 한다. 클라이언트에서 코딩을 하면, 클라이언트 플랫폼이 플러터 말고 다른 것으로 되면, 클라이언트 코딩 로직이 번거러워진다.

- 채팅방에 비밀번호가 있는 경우, 백엔드를 통해서 입장을 해야 한다. 즉, FireFlutterExtensions 백엔드를 설치해야 한다.


## 1:1 채팅방에 상대방의 사진와 이름이 나오는 로직

- 최소 채팅방에 입장하는 경우, `ChatRoomBody` 에서 채팅방을 만들고 `/chat-join` 에 정보를 기록하는데, 상대방의 이름과 사진을 읽어서 저장한다.
- 참고로 채팅 메시지를 보내기 전에는 `/chat-join` 를 나의 uid 아래에만 저장하고 상대방의 uid 아래에는 저장하지 않는다. 이렇게 하므로서 채팅 메시지를 보내기 전에는 상대방의 채팅 목록에 나의 사진/이름이 표시되지 않는다.

## 코딩 기법

### 채팅 방에서 사용자의 전체 채팅 메시지 가져오기

아래와 같이 하면, 해당 채팅방의 모든 메시지를 `uid` 순서로 한번에 다 가져온다. 다운로드 용량이 많아 데이터를 너무 가져오지 않도록 주의 할 필요가 있다.

```dart
final snapshot = await Ref.chatRoomMessages('chat-room-id')
    .orderByChild('uid')
    .get();

if (snapshot.exists) {
  print((snapshot.value as Map).keys.length);
  for (var key in (snapshot.value as Map).keys) {
    print((snapshot.value as Map)[key]['uid'] +
        ' : ' +
        ((snapshot.value as Map)[key]['text'] ?? '--'));
  }
}
```



### 채팅방에서 로그인한 사용자의 메시지 한 개만 가져오기

예를 들어, 모든 회원이 의무적으로(자동으로 채팅방 입장) 사용하는 전체 채팅방이 있는 경우, 회원 가입을 한 다음, 해당 채팅 방에 (가입인사) 채팅을 남기도록 권유하는 경우, 로그인 한 사용자가 해당 채팅방에 채팅을 했는지 안했는지 확인하기 위해서, 딱 하나의 채팅 메시지만 가져와서, 채팅을 했는지 하지 않았는지 알 수 있다.

아래와 같이 코딩을 하면 된다.

```dart
// Get the chat room first.
final ChatModel chatRoom = await ChatModel.get('chat-room-id');

final snapshot = await ChatModel.messageseRef
    .orderByChild('uid')
    .get();

if (snapshot.exists) {
  print((snapshot.value as Map).keys.length);
  for (var key in (snapshot.value as Map).keys) {
    print((snapshot.value as Map)[key]['uid'] +
        ' : ' +
        ((snapshot.value as Map)[key]['text'] ?? '--'));
  }
}
```

### ChatModel에서 ChatRoom 가져오기

- 채팅방 메시지를 표시하기 전에 완전한 채팅방 모델 인스턴스가 필요합니다. 예를 들어,
    - 사용자가 방에 있는지 확인하려면,
    - 사이트 미리보기 표시 여부 또는 이미지 표시 옵션을 확인하려면,
    - 채팅방 설정에 따라 암호 입력 상자를 표시하려면,
    - 등등

명확히 하자면, ChatRoom과 ChatModel은 두 가지 다른 모델이다. ChatRoom은 채팅방의 일부 세부 정보를 보유하는 모델이고, ChatModel은 채팅방과 채팅 메시지의 모든 세부 정보를 가지는 모델이다. 참고로 ChatModel.room 이 ChatRoom 모델이며, 이를 통해서 ChatRoom 모델을 참조 할 수 있다.

### Order

- 채팅 메시지 순서는 마지막 메시지의 `order` 필드에 의해 정렬된다.
    - 이전 메시지보다 늦은 메시지는 이전 메시지보다 작은 값을 가져야 하며, 최신 메시지는 항상 가장 작은 값이어야 한다.
    - 프로그래밍 방식으로 order를 지정하지 않고 채팅 메시지를 보낼 경우, 메시지가 잘못된 위치에 표시될 수 있다. (가장 위쪽에 표시될 수 있음).

### 채팅방 만들기

채팅방을 만드는 방법은 다음과 같다.

```dart
/// 아래와 같이 채팅방 생성
final room = await ChatRoom.create(
  name: '채팅방 이름',
  description: '채팅방 설명',
  isOpenGroupChat: true, // 오픈 채팅 방
);
/// 채팅방을 생성하고 나서, 곧바로 채팅방에 입장한다. 즉, rtdb 의 /chat-joins 에 방 입장 정보를 기록한다.
final chat = ChatModel(room: room);
await chat.join(forceJoin: true);

/// 그리고 나서 해당 채팅방으로 입장하면 된다. 물론 안해도 된다.
```

`ChatRoom.create()` 을 통해 채팅방을 생성하고, 추가로 `ChatModel.join()` 을 호출해야 한다.

`ChatModel.join()` 을 호출하면 /chat-rooms/all/users에 {[uid]: true}가 생성된다.

참고로, `await ChatRoom.fromRoomdId(id).join(myUid!, forceJoin: true);` 와 같이 해도 채팅방에 입장 (join) 할 수 있다.



참고로 화면에 ChatMessageListView 위젯이 표시되면, `ChatMessageListView::initState() -> ChatModel::resetNewMessage()`에서 RTDB `chat-joins/all`에 `{order: 0}`가 내부적으로 저장된다.

그러나 더 간편하게 채팅방을 만들고 싶다면, 미리 제공된 `ChatService.instance.showChatRoomCreate()` 함수를 사용할 수 있다.  이 때, `authRequired` 옵션을 주면 본인 인증한 사용자만 입장을 할 수 있도록 제한 할 수 있다.

채팅방 생성 UI 디자인을 사용자 정의하려면 DefaultChatRoomEditDialog을 복사하고 수정할 수 있다.






### 채팅방 입장

채팅방에 입장을 하려면 간단히, `ChatService.instance.showChatRoomScreen()` 을 호출하면 새창으로 채팅방을 보여준다.

새창이 아니라, 탭바 또는 화면의 한 부분으로 추가를 하고 싶은 경우 `ChatRoomBody()` 위젯을 사용하면 된다.

`ChatRoomBody()` 은 기본적으로 채팅 헤더, 메시지 목록, 채팅 입력 박스 세 가지가 포함되어져 있다. 그리고 여러가지 옵션이 있으며 이를 통해서 디자인을 변경 할 수. 있다 물론 원한다면 `ChatRoomBody()` 를 복사해서 모든 것을 직접 작성해도 된다.


```dart
// For 1:1 chat room, using other user's uid
ChatRoomBody(uid: 'user-uid');

...

// Using room-id for 1:1 or group chat room
ChatRoomBody(roomId: 'room-id');

...

// Using snapshot -> ChatRoom
ChatRoom chatRoom = ChatRoom.fromSnapshot(dataSnapshot);
ChatRoomBody(room: chatRoom);
```


```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:silvers/models/club/club.dart';

class ClubScreen extends StatefulWidget {
  static const String routeName = '/Club';
  const ClubScreen({super.key, required this.club});

  final Club club;

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('클럽 제목 : ${widget.club.name}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '소개'),
              Tab(text: '일정'),
              Tab(text: '채팅'),
              Tab(text: '게시판'),
              Tab(text: '사진첩'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Text("모임 소개. @TODO 시놀 보고 따라 만든다."),
            const Text(
                "미팅 시간 날짜 약속 @TODO 간단하게 게시판 형태로 만든다. 날짜를 수동으로 입력한다. 시놀 보고 따라 만든다."),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: ChatRoomBody(
                roomId: widget.club.id,
                displayAppBar: false,
                appBarBottomSpacing: 0,
              ),
            ),
            const Text(
                "게시판. 서브 카테고리 없이 그냥 글만 쓸 수 있게 한다. 단, 공지사항은 따로 맨 위에 최대 5개까지 노출 할 수 있도록 한다."),
            const Text("사진첩, 그냥 갤러리로 만든다."),
          ],
        ),
      ),
    );
  }
}
```

### Updating Chat Room

To update a chat room, call `ChatService.instance.showChatRoomSettings(roomId: ...)`, and use the `DefaultChatRoomEditDialog` widget, which is the same widget used for creating a chat room.

When updating a chat room, you can optionally specify authenticated members and gender. If the `gender` has a value of `M` or `F`, only members of that gender can access (enter) the room. For `verified`, regardless of gender, if the user is verified, they can access the room. Note that authenticated members and gender refer to user information.

### Sending Chat Messages

To send a chat message into a room (or to a user), `ChatMessageInputBox()` can be used as Input box. You can copy this widget and customize by yourself.

```dart
// the ChatRoom is required. Get it.
ChatRoom room = ChatRoom.fromSnaphot(snapshot);

// the `chat` should be the model of the room
ChatModel chat = ChatModel(room: room);

ChatMessageInputBox(
  chat: chat,
),
```

You can also send a chat message to a user or to a room programatically (without entering a chat room screen) like below.

```dart
// the ChatRoom is required. Get it.
ChatRoom room = ChatRoom.fromSnaphot(snapshot);

ChatModel chat = ChatModel(room: room);

// This may throw error if user is not logged in.
chat.sendMessage(text: 'Text Message to send', url: 'photo.url.com');

```

### Getting Chat Messages in a Room

To display chat messages in a room, `ChatMessageListView()` can be used.

```dart
// the ChatRoom is required. Get it.
ChatRoom room = ChatRoom.fromSnaphot(snapshot);

// the `chat` should be the model of the room
ChatModel chat = ChatModel(room: room);

ChatMessageListView(
  chat: chat,
),
```

For customization, these can be used. Edit them as needed:

```dart
DatabaseReference ref = ChatService.instance.messageRef(roomId: roomId).orderByChild('order');

FirebaseDatabaseQueryBuilder(
  pageSize: 100,
  query: ref,
  builder: (context, snapshot, _) {
    if (snapshot.isFetching) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Something went wrong! ${snapshot.error}');
    }
    if (snapshot.docs.isEmpty) {
      return Center(child: Text('There is no message, yet.'));
    }
    finally return the list
    return ListView.builder(
      reverse: true,
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
          snapshot.fetchMore();
        }
        final message = ChatMessage.fromSnapshot(snapshot.docs[index]);

        /// 채팅방의 맨 마지막 메시지의 order 를 지정.
        chat.resetRoomMessageOrder(order: message.order);

        return YourCustomChatBubble(
          message: message,
        );
      },

    );
  },
);

```

### Opening the Settings for the Chat Room

To open the Settings for the Chat Room

```dart
ChatService.instance.showChatRoomSettings(
  context: context,
  roomId: chat.room.id,
);
```

### 채팅방 목록 (Chat Room List)

Due to the characteristics of RTDB, it is challenging to list chat rooms:

- My 1:1 chat room list by date
- My entire chat room list by date
- Open chat list by date

Therefore, by using `isSingleChat` with a negative time, you can display my 1:1 chat room list in chronological order. This is the same for `isGroupChat` and `isOpenGroupChat`.

To display the entire chat room list at once, get all chat rooms and display them. For example, when displaying my 1:1 chat room list, get the entire list and display it in chronological order. Do the same for my entire group chat room and all open chat room. However, this method may not be suitable if each individual's (user's) chat rooms are too numerous. Overall, it seems reasonable to have up to 500 per person. Up to 2,000 should also be acceptable. However, if a user has more than 2,000 rooms, it might be a bit challenging. Therefore, limiting the number of rooms may be one way. Additionally, having more than 2,000 open chats might be problematic.

Here is an example code to show chat room list. This will show list of all Chat Rooms by the currently logged in user. Take note that the `Field.order` is the same as 'order'.

```dart
FirebaseDatabaseQueryBuilder(
  query: ChatService.instance.joinsRef
      .child(myUid!)
      .orderByChild(Field.order),
  pageSize: 50,
  builder: (context, snapshot, _) {
    if (snapshot.isFetching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Text('Something went wrong! ${snapshot.error}');
    }
    if (snapshot.hasMore == false && snapshot.docs.isEmpty) {
      return Text('No chat rooms');
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
          snapshot.fetchMore();
        }
        final room = ChatRoom.fromSnapshot(snapshot.docs[index]);
        return ChatRoomListTile(room: room);
      },
    );
  },
);

```

#### DefaultChatRoomListView Widget

나의 채팅 방 목록을 표현하기 위해서 `DefaultChatRoomListView` 을 사용하면 된다.

예제

```dart
DefaultChatRoomListView(),
```


전체 스크린 예제. 참고로 아래의 예제는 그룹 채팅방 생성 코드를 포함하고 있다.

```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/Chat';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ChatService.instance
                .showChatRoomCreate(
                  context: context,
                )
                .then(
                  (room) => ChatService.instance.showChatRoomScreen(
                    context: context,
                    room: room,
                  ),
                ),
          ),
        ],
      ),
      body: const DefaultChatRoomListView(),
    );
  }
}
```

#### ChatRoomListView

`ChatRoomListView` 를 통해서 나의 채팅방 목록을 화면에 표시 할 수 있다. 이 위젯은 `ListView.separated` 의 대부분의 속성을 지원한다. 그래서 그냥 ListView 를 쓴다는 느낌으로 사용하면 된다.

아래와 같이 `ChatRoomListView` 를 사용하면 된다.

```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/Chat';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ChatService.instance
                .showChatRoomCreate(
                  context: context,
                )
                .then(
                  (room) => ChatService.instance.showChatRoomScreen(
                    context: context,
                    room: room,
                  ),
                ),
          ),
        ],
      ),
      body: ChatRoomListView(
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (room, index) => ListTile(
          title: Text(room.name ?? 'no name'),
          subtitle: Text(room.text ?? 'no text'),
          onTap: () => ChatService.instance.showChatRoomScreen(
            context: context,
            room: room,
          ),
        ),
      ),
    );
  }
}
```


참고로, 위에서 `itemBuilder` 에 `ChatRoomListTile` 을 써도 된다.

예제

```dart
ChatRoomListView(
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (room, index) => ChatRoomListTile(room: room),
),
```

이 처럼, FireFlutter 에는 미리 제공되는 위젯이 충분히 있다. 이를 잘 활용하거나 이러한 위젯의 소스 코드를 복사해서 나만의 것으로 만들 수 있다.

참고로, `ChatRoomListView` 에는 query 를 전달하여 원하는 데이터베이스에서 원하는 채팅방을 가져와 화면에 표시 할 수 있다.

예제

```dart
ChatRoomListView(
  query: ChatService.instance.joinsRef
      .child(myUid!)
      .orderByChild(Field.order),
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (room, index) => ChatRoomListTile(room: room),
),
```

#### 오픈 챗 목록하기

오픈 챗은 누구나 입장을 할 수 있는 채팅방이다. 아래와 같이 오픈 채팅방 목록을 표현 할 수 있다.

```dart
ChatRoomListView(
  openChat: true,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (room, index) => ChatRoomListTile(room: room),
),
```

#### 직접 데이터베이스에 쿼리하여 채팅방 목록하기

정말 원한다면, 직접 데이터베이스에 쿼리를 해서, 채팅방 정보를 가져와 표현 할 수 있다. 물론, 채팅방의 데이터베이스 구조를 잘 알아야 할 것이다. 예를 들면, 1:1 채팅방만 목록하거나, 그룹 채팅방만 목록하거나, 오픈 채팅방만 목록하거나 하는 등의 작업을 할 수 있다.

또는 chat room 관련 정보를 firestore 로 미러링해서 더 자세한 쿼리(필터링)를 할 수 있다.


현재 사용자의 채팅방을 표시하고 싶다면 아래와 같이 쿼리를 하면 된다. 참고로 `Field.order` 순서로 쿼리를 하면 채팅 메시지를 확인하지 않은 채팅방의 목록이 먼저 나온다. 즉, 새로운 채팅 메시지가 있는 방이 위에 나오는 것이다.

```dart
FirebaseDatabaseQueryBuilder(
  query: ChatService.instance.joinsRef
      .child(myUid!)
      .orderByChild(Field.order)
      .startAt(false),
  pageSize: 50,
  builder: (context, snapshot, _) {
    ...
  },
);
```

For `ChatService.instance.joinsRef.child(myUid!)`, the `joinsRef` is the reference for the chat rooms. In RTDB the node is `chat-joins/user-uid/room-id`. Therefore, `myUid` is required.

The `Field.order` is the same with 'order'. This can be used to get all the group chat that the currently logged in user is joined. Here are the list of fields can be used in `joinsRef`:

1. `Field.order` - same as 'order'.
   - All chat room - single or group chat
2. `Field.singleChatOrder` - same as 'singleChatOrder'.
   - All single chat room
3. `Field.groupChatOrder` - same as 'groupChatOrder'.
   - All group chat room

##### Chat Rooms not Necessarily Joined by the Currently Logged in User (roomsRef)

For `ChatService.instance.roomsRef`, the `roomsRef` is the reference for the chat rooms. In RTDB the node is `chat-rooms/roon-id`.

```dart
FirebaseDatabaseQueryBuilder(
  query: ChatService.instance.roomsRef
      .orderByChild(Field.openGroupChatOrder)
      .startAt(false),
  pageSize: 50,
  builder: (context, snapshot, _) {
    ...
  }
);
```

Here are the list of fields can be used in `roomsRef`:

1. `Field.groupChatOrder` - same as 'groupChatOrder'.
   - All group chat room - open or closed
2. `Field.openGroupChatOrder` - same as 'openGroupChatOrder'.
   - All open group chat room

## Toggling Notifications

The on and off switch for push notification is set under each user's uid in `users` field of the chat room.
For instance, if the value is `true` like `/chat-rooms/<room-id>/users/ {uid-a: true}`, then the user of `uid-a` will get push notification. If it's `false`, then the user will not get any push notification.

You can set true or false for the login uid in the 'users' field of the chat room like below;

```dart
IconButton(
  onPressed: () async {
    await chat.room.toggleNotifications();
  },
  icon: Database(
    path: Path.chatRoomUsersAt(chat.room.id, myUid!),
    builder: (v) => v == true
        ? const Icon(Icons.notifications_rounded)
        : const Icon(Icons.notifications_outlined),
  ),
),
```

When `v` is true, notifications is toggled on. Else, toggled off.

## Group Chat Room

### Creating a Group Chat

Use `ChatService.instance.showChatRoomCreate()` for the default way on creating a chat room.

```dart

IconButton(
  onPressed: () async {
    final room = await ChatService.instance.showChatRoomCreate(context: context);
    It is recommended to show the newly created room to the user.
    if (room != null && mounted) {
      ChatService.instance.showChatRoom(context: context, roomId: room.id);
    }
  },
  icon: const Icon(Icons.comment),
),

```

Automatically, creator of the room will join to the newly created room after submitting.

### 사용자 초대

- 그룹 채팅방에 사용자 초대를 커스텀 디자인 할 수 있다. 물론 디자인 뿐만아니라 로직 전체를 마음데로 변경 할 수 있다.

- 채팅방에 친구 추가 버튼이 있는데, 이 버튼 자체를 덮어서서 아래와 같이 디자인을 변경 할 수 있다. 물론 로직도 변경하여, 채팅방에 사용자 추가하는 함수만 호출하면 된다.

```dart
ChatService.instance.init(
  customize: ChatCustomize(
    chatRoomInviteButton: (chatRoom) {
      return ChatRoomInviteScreenButton(room: chatRoom);
    },
```

To show the default invite screen, add these code:

```dart
IconButton(
  onPressed: () async {
    ChatService.instance.showInviteScreen(context: context, room: chat.room);
  },
  icon: const Icon(Icons.person_add_rounded),
),
```

The `ChatService.instance.showInviteScreen()` will show a list of users in a list view who can be added. It uses `DefaultChatRoomInviteScreen` widget. Check this code for reference in customization:

```dart
// Showing the list screen
await showGeneralDialog<ChatRoom?>(
  context: context,
  pageBuilder: (_, __, ___) => CustomChatRoomInviteScreen(room: room),
);
...
// Update this into your custom Invite screen
class CustomChatRoomInviteScreen extends StatelessWidget {
  const CustomChatRoomInviteScreen({
    super.key,
    required this.room,
  });
  final ChatRoom room;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구 초대'),
      ),
      body: FirebaseDatabaseListView(
        query: Ref.users.orderByChild('order'),
        itemBuilder: (context, snapshot) {
          final user = UserModel.fromSnapshot(snapshot);
          return ListTile(
            leading: UserAvatar(uid: user.uid),
            title: Text(user.displayName ?? ''),
            trailing: const Icon(Icons.add),
            onTap: () async {
              await room.invite(user.uid);
            },
          );
        },
      ),
    );
  }
}
```

### Group Chat Members

To show the default members screen, add these code:

```dart
await ChatService.instance.showMembersScreen(
  context: context,
  room: chat.room,
);
```

It uses the `DefaultChatRoomMembersScreen(room: room)` when it is not customized.

### Removing a Group Chat Member

Here is an example of a button that removes a user from the group chat. It uses `room.remove(member.uid)` code to remove the user.

```dart
final room = ChatRoom.fromSnapshot(snapshot);
// ...
final member = UserModel.fromSnapshot(snapshot);
// ...
TextButton(
  onPressed: () {
    room.remove(member.uid);
    Navigator.pop(context);
  },
  child: const Text('Remove User'),
),
```

## Management

- You can use the default admin screen. Just call `AdminService.instance.showDashboard()`.


## 채팅 메시지 전송 콜백 - beforeMessageSent, afterMessageSent

채팅 메시지를 보내기 전이나, 보낸 다음 어떤 작업을 하고 싶은 경우에 커스텀 콜백을 쓸 수 있다.

예를 들면, 회원이 이름이나 사진을 업데이트하지 상태라면 채팅 메시지를 보낼 때 아래와 같이 에러가 나도록 할 수 있다.

```dart
ChatService.instance.init(
  beforeSendMessage: (chat) {
    if (my!.photoUrl.isEmpty || my!.displayName.isEmpty) {
      error(
          context: context,
          title: '회원 정보 미완성',
          message: '빠진 회원 정보를 모두 입력해 주세요.');
      throw '프로필이 미완성입니다.';
    }
  }
);
```



실제 발생한 상황 중 한 예를 들면, A 는 한국어를 쓰고 B 는 따갈로그어를 쓰는 겨우, A 가 한국어로 채팅을 하면 B 에게 따갈로그어로 번역되어 전송이 되어야 한다. 그리고 푸시 알림 엮시 한국에서 따갈로그어로 번역이 되어서 전송이 되어야 한다. 이렇게 하기 위해서는 채팅 메시지를 DB 에 집어 넣기 전에, 먼저 번역을 해야 하는데, `beforeMessageSent` 을 통해서 번역을 하면 된다. 참고로 번역은 `afterMessageSent` 에서도 할 수 있다. 하지만 DB 에 기록된 후 번역을 하는 데, 푸시 알림은 DB 에 기록되자 마자 곧 바로 메시지를 보내므로 번역된 내용이 전달되지 않고 사용자가 입력한 원문이 전달된다.

예제

```dart
ChatService.instance.init(
  /// 다음은 한국인 A 가 필리피노 B 에게 채팅하면, 한국어를 따갈로그어로 번역해서 채팅 메시지를 전송한다.
  ///
  /// 메시지 전송 전에 콜백으로 message 값을 변경 후 리턴
  /// [chat] 은 채팅 모델. 1:1 채팅에서 상대방의 uid 를 알 수 있다>
  beforeMessageSent: (Map<String, dynamic> message, ChatModel chat) async {
      /// If there is no text to translate, then just return
      if (message['text'] != null && message['text'].trim().isEmpty) {
        return message;
      }
      if (message['text'] == null) {
        return message;
      }

      /// Get the other user's language code
      final otherUserSettings =
          await UserSetting.get(chat.room.otherUserUid!);
      final otherUserLanguageCode = otherUserSettings.languageCode;
      if (otherUserLanguageCode == null) return message;

      /// Get my language code
      final myUserSettings = await UserSetting.get(myUid!);
      final myUserLanguageCode = myUserSettings.languageCode;
      if (myUserLanguageCode == otherUserLanguageCode) return message;

      /// ChatGPT 3.5 Turbo 번역
      /// 아래는 번역을 아주 잘 해 주는 코드이다.
      final openAI = OpenAI.instance.build(
        token: AppConfig.openAiKey,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true,
      );

      final String userInputMessage = message['text'];

      /// Gpt3 turbo chat
      String text = userInputMessage.trim();
      if (text.endsWith('.') == false) {
        text = '$text.';
      }
      final prompt2 =
          "Translate below into ${otherUserLanguageCode.language}.\n\n$text";

      final request2 = ChatCompleteText(
        messages: [
          Map.of({
            "role": "system",
            "content":
                'You are a language translator. Not a chatbot. Not a human. Just translate the text.'
          }),
          Map.of({
            "role": "assistant",
            "content":
                "Don't act as a chatbot. Don't answer the text. Just translate the text.",
          }),
          Map.of({
            "role": "user",
            "content": prompt2,
          }),
        ],
        maxToken: 200,
        model: GptTurboChatModel(),
      );

      final response2 = await openAI.onChatCompletion(request: request2);

      String response = '';
      for (var element in response2!.choices) {
        response = element.message?.content.trim() ?? '';
        if (response.isNotEmpty) break;
      }
      message['text'] = '$response\n\n($userInputMessage)';
      return message;
    },
/// 채팅 메시지 전송 후, Google 번역하는 예
afterMessageSent: (ChatMessage message) async {
  if (message.text == null || message.text!.isEmpty) return;

  /// 상대방의 언어코드
  final room = await ChatRoom.get(message.roomRef.key!);
  final otherUserSettings = await UserSetting.get(room.otherUserUid!);
  final otherUserLanguageCode = otherUserSettings.languageCode;
  if (otherUserLanguageCode == null) return;

  /// 나의 언어코드
  final myUserSettings = await UserSetting.get(myUid!);
  final myUserLanguageCode = myUserSettings.languageCode;

  /// 나의 언어와 상대방의 언어가 동일하면 리턴
  if (myUserLanguageCode == otherUserLanguageCode) return;

  /// 구글 번역
  final translator = GoogleTranslator();
  final translation =
      await translator.translate(message.text!, to: otherUserLanguageCode);
  if (translation.text == message.text) return;

  /// 번역한 내용을 DB 에 바로 저장
  await message.ref!.update({
    Field.text: "${translation.text}\n\n(${message.text})",
  });
});
```


## 채팅 방 생성 다이얼로그 UI 변경

* 채팅 방 생성을 할 때, 아래와 같이 Theme 을 통해서 UI 변경을 할 수 있다. 또는 `DefaultChatRoomEditDialog` 를 복사하여 모든 것을 직접 작성해도 된다.

```dart
ChatService.instance.init(
  customize: ChatCustomize(
    chatRoomInviteButton: (chatRoom) {
      return ChatRoomInviteScreenButton(room: chatRoom);
    },
    chatRoomEditDialogBuilder: ({required context, roomId}) => Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.blue,
              displayColor: Colors.red,
            ),
      ),
      child: DefaultChatRoomEditDialog(
        roomId: roomId,
      ),
    ),
  ),
);
```

* UI 작업 팁: 참고로, UI 작업을 할 때, 매번 다이얼로그를 닫고 다시 실행해야하는 번거로움이 발생 할 수 있는데, 필요 없이, 아래와 같은 코드를 initState() 에 넣어 두고, CMD+R 등으로 간단하게 다얼로그를 열어서 변경된 디자인을 보다 편하게 확인 할 수 있다.

```dart
showDialog(
  context: globalContext,
  builder: (context) => Theme(
    data: Theme.of(globalContext).copyWith(
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.fromLTRB(12, 0, 24, 24),
      ),
    ),
    child: const DefaultChatRoomEditDialog(
      roomId: null,
    ),
  ),
);
```



## 채팅방 입장했는데 로그인을 하지 않은 경우

일반적으로 로그인을 해야지만 앱의 기능을 이용 할 수 있는 경우는 필요가 없지만,
- 로그인을 하지 않아도 앱을 사용할 수 있도록 하는 경우
- 특히 메뉴에서 전체 채팅방과 같이 채팅방에 바로 들어갈 수 있도록 해 놓는 경우

로그인을 확인해야 할 필요가 있다.

참고로 채팅방에 입장 할 때에는 항상 `ChatService.instance.showChatRoomScreen` 을 통해서 입장하는 이 함수에서 로그인이 안되어져 있다면 `UserService.instance.init(loginRequired: (action, data) => ... )` 콜백 함수가 호출된다.

자세한 것은 user.md 를 참고한다.


## 채팅 메시지 수 표시

아래와 같이 `ChatTotalNoOfNewMessage` 위젯으로 적절히 표현 할 수 있다.

```dart
NavigationDestination(
  icon: const SizedBox(
    width: 32,
    child: Stack(
      children: [
        FaIcon(FontAwesomeIcons.thinComment),
        Positioned(
          right: 0,
          child: ChatTotalNoOfNewMessage(),
        ),
      ],
    ),
  ),
  label: context.ke('채팅', 'Chat'),
),
```

만약, 커스터마징이 필요하면 아래와 같이 한다.

```dart
NavigationDestination(
  icon: ChatTotalNoOfNewMessage(
    builder: (_, n, child) => SizedBox(
      width: n == 0 ? null : 32,
      child: n == 0
          ? const FaIcon(FontAwesomeIcons.thinComment)
          : Stack(
              children: [
                const FaIcon(FontAwesomeIcons.thinComment),
                Positioned(
                  right: 0,
                  child: child,
                ),
              ],
            ),
    ),
  ),
  label: context.ke('채팅', 'Chat'),
),
```

## 채팅 메시지 삭제

- 관리자와 마스터는 타인의 채팅 메시지를 삭제할 수 있다.

- 자기 자신의 사진을 삭제할 수 있다.

## 그룹 채팅 사용자 차단

- 그룹 채팅방에서 관리자 또는 마스터가 특정 사용자를 차단 할 수 있다.

- 차단을 하면, chat_rooms 의 `blockedUsers` 에 해당 사용자의 uid 가 저장된다.

- 차단이 되면,
  - 먼저, security rules 에 의해서, 메시지를 볼 수 없고, 전송 할 수 없게 된다.
  - 채팅 메시지를 전송하려고 할 때, 프로그램적으로, FlutterFireException 을 발생시킨다.


- 채팅방의 메뉴에서 차단 해제를 할 수 있다.


- 사용자 차단을 하는 것은 흔하지 않은 일이고, 프로그램적으로 크리티컬한 에러가 발생하지 않는다.
  - 다만, 차단되면
    - 차단된 사용자는 security rules 에 의해서 메시지를 바로 읽을 수 없으며,
    - 채팅 입력 창이 화면에 그대로 나올 수 있다. 하지만, security rules 에 의해서 permission denied 에러가 발생하고, `Code.chatSendMessageBlockedUser` FireFlutterException 이 발생한다.

- 차단된 상태에서 차단 해제되면, 사용자는 에러 없이, 채팅메시지를 전송할 수 있다.
  - 하지만, 메시지 목록에는 여전히 permission denied 로 나올 수 있는데, 이것은 커스텀 코딩으로 수정 할 수 있다.
  기본적으로는 `차단된 상태에서 차단 해제되면` 채팅방을 나갔다가 다시 들어와야 채팅 메시지가 올바로 보인다.


## 성별 설정

- 채팅방을 생성/수정 할 때, 성별을 지정하여 해당 성별의 사용자만 입장하게 할 수 있다.
- 이 때, verified user 옵션을 같이 사용해야, 성별을 정확하게 판단 할 수 있다.



## 알려진 문제


- 채팅방 A, B, C 가 있는 경우, A 보다 C 가 나중에 새로운 채팅 메시지가 있다면, A 가 먼저 목록되고 C 가 나와야하는데, 현재는 C 가 먼저 나오고 A 나온다. 즉, 목록에 약간 문제가 있지 않나 싶다.
