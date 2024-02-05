import 'package:firebase_database/firebase_database.dart';
import 'package:fireship/fireship.dart';
import 'package:flutter/material.dart';

/// Chat
///
class ChatService {
  static ChatService? _instance;
  static ChatService get instance => _instance ??= ChatService._();

  ChatService._() {
    dog('--> ChatService._()');
  }

  /// Firebase Realtime Database Chat Functions
  ///
  ///

  /// Firebase Realtime Database instance
  FirebaseDatabase get rtdb => FirebaseDatabase.instance;
  DatabaseReference get roomsRef => rtdb.ref().child('chat-rooms');
  DatabaseReference get messageseRef => rtdb.ref().child('chat-messages');
  DatabaseReference roomRef(String roomId) => roomsRef.child(roomId);
  DatabaseReference messageRef({required String roomId}) =>
      rtdb.ref().child('chat-messages').child(roomId);

  /// [roomUserRef] is the reference to the users node under the group chat room. Ex) /chat-rooms/{roomId}/users/{my-uid}
  DatabaseReference roomUserRef(String roomId, String uid) =>
      rtdb.ref().child('chat-rooms/$roomId/users/$uid');

  DatabaseReference get joinsRef => rtdb.ref().child('chat-joins');
  DatabaseReference joinRef(String myUid, String roomId) =>
      joinsRef.child(myUid).child(roomId);

  ChatCustomize customize = const ChatCustomize();

  init({
    ChatCustomize? customize,
  }) {
    dog('--> ChatService.init()');
    this.customize = customize ?? this.customize;
  }

  Future createRoom({
    required String name,
    required bool isGroupChat,
    required bool isOpenGroupChat,
  }) async {
    final room = await ChatRoomModel.create(
      name: name,
      isOpenGroupChat: isOpenGroupChat,
    );

    return room;
  }

  Future showChatRoom({
    required BuildContext context,
    String? uid,
    String? roomId,
    ChatRoomModel? room,
  }) async {
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) =>
            DefaultChatRoomScreen(
              uid: uid,
              roomId: roomId,
              room: room,
            ));
  }

  Future<ChatRoomModel?> showChatRoomCreate(
      {required BuildContext context}) async {
    return await showDialog<ChatRoomModel?>(
      context: context,
      builder: (_) => const DefaultChatRoomEditDialog(),
    );
  }

  Future showChatRoomSettings({
    required BuildContext context,
    required String roomId,
  }) async {
    return await showDialog<ChatRoomModel?>(
      context: context,
      builder: (_) => DefaultChatRoomEditDialog(roomId: roomId),
    );
  }

  /// Display a dialog to invite a user to a chat room.
  Future showInviteScreen({
    required BuildContext context,
    required ChatRoomModel room,
  }) async {
    return await showGeneralDialog<ChatRoomModel?>(
      context: context,
      pageBuilder: (_, __, ___) => DefaultChatRoomInviteScreen(room: room),
    );
  }
}
