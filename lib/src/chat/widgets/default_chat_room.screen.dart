import 'package:fireship/fireship.dart';
import 'package:flutter/material.dart';

/// 채팅방
///
/// 채팅 메시지를 보여주고, 새로운 채팅 메시지를 전송할 수 있도록 한다.
///
/// TODO 채팅방 정보에 따른 입장 권한, 비밀번호 확인 등의 절차가 필요하므로, 채팅방 정보를 먼저 읽어야만 한다.
/// TODO 그래서, 옵션으로 roomId 또는 uid 를 받고, 방정보 천체를 받을 수 있도록 한다. id 만들어 오면, 방 정보를 먼저 읽는다.
/// 그래야 로직이 편해진다.
///
class DefaultChatRoomScreen extends StatefulWidget {
  const DefaultChatRoomScreen({
    super.key,
    this.uid,
    this.roomId,
  });

  final String? uid;
  final String? roomId;

  @override
  State<DefaultChatRoomScreen> createState() => _DefaultChatRoomScreenState();
}

class _DefaultChatRoomScreenState extends State<DefaultChatRoomScreen> {
  late ChatModel chat;

  @override
  void initState() {
    super.initState();

    if (notLoggedIn) {
      return;
    }

    /// 빠르게 화면을 보여주기 위해서, uid 또는 roomId 로 부터 임시 ChatModel instance 생성 후,
    chat = ChatModel(
      room: widget.uid != null
          ? ChatRoomModel.fromUid(widget.uid!)
          : ChatRoomModel.fromRoomdId(widget.roomId!),
    );

    /// 방 정보 전체를 한번 읽고, 이후, 실시간 업데이트. subscribe 할 때, join 을 한다.
    chat.subscribeRoomUpdate(onUpdate: () async {
      // 그리고 채팅방에 join (이미 join 되어 있으면, 아무것도 하지 않는다.)
      try {
        await chat.join();
      } on ErrorCode catch (e) {
        if (e.code == Code.chatRoomNotVerified) {
          rethrow;
        }
      } catch (e) {
        rethrow;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    /// 실시간 업데이트 subscription 해제
    chat.unsubscribeRoomUpdate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 로그인을 하지 않았으면, 로그인 요청 위젯 표시
    if (notLoggedIn) {
      return const DefaultLoginFirstScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
            ],
            onSelected: (v) {
              if (v == 'edit') {
                ChatService.instance.showChatRoomSettings(
                  context: context,
                  roomId: chat.room.id,
                );
              }
            },
            tooltip: '채팅방 설정',
            icon: const Icon(Icons.menu_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageListView(
              chat: chat,
            ),
          ),
          SafeArea(
            top: false,
            child: ChatMessageInputBox(
              chat: chat,
            ),
          ),
        ],
      ),
    );
  }
}