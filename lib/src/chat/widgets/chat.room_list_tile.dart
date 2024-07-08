import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// ChatRoomListTile
///
/// [room] 채팅방 정보 (ChatRoom)
///
/// [stateMessageAsSubtitle] 상태 메시지를 subtitle 로 표시할지 여부.
/// 1:1 채팅 메시지 목록 보다는, 친구 목록을 할 때 사용 할 수 있다. 그룹 채팅 목록에는 false 로 하면 마지막 메세지가
/// 화면에 표시된다.
///
/// [contentPadding] ListTile 의 contentPadding. UI 디자인을 위해 사용한다.
class ChatRoomListTile extends StatelessWidget {
  const ChatRoomListTile({
    super.key,
    required this.room,
    this.stateMessageAsSubtitle,
    this.contentPadding,
  });

  final ChatRoom room;
  final bool? stateMessageAsSubtitle;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // visualDensity: VisualDensity.compact,
      // dense: true,
      contentPadding: contentPadding,
      leading: ChatRoomAvatar(
        room: room,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              room.name ?? '',
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: subtitle(context, room),
      onTap: () {
        dog('room.id: ${room.id}');
        dog('room.id: ${room.key}');
        ChatService.instance
            .showChatRoomScreen(context: context, roomId: room.id);
        // context.push(AllRoomScreen.routeName, extra: {'roomId': room.id});
      },
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (room.updatedAt! > 0)
            Text(
              dateTimeShort(
                  DateTime.fromMillisecondsSinceEpoch(room.updatedAt!)),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 10),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (room.isGroupChat)
                Text(
                  '${room.noOfUsers ?? ''}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary.tone(50),
                      ),
                ),
              Value(
                ref: ChatRoom.usersAtRef(room.id, myUid!),
                builder: (v) => v == true
                    ? Icon(
                        Icons.notifications_rounded,
                        color: Theme.of(context).colorScheme.secondary.tone(50),
                        size: 20,
                      )
                    : Icon(
                        Icons.notifications_off_outlined,
                        color: Theme.of(context).colorScheme.secondary.tone(70),
                        size: 20,
                      ),
              ),
              const SizedBox(height: 2),
              ChatNewMessage(room: room),
            ],
          ),
        ],
      ),
    );
  }

  String text(ChatRoom room) {
    if (room.text != null) return room.text!.replaceAll('\n', ' ');
    if (room.url != null) return '사진을 보내셨습니다.';
    return '';
  }

  Widget subtitle(BuildContext context, ChatRoom room) {
    // 1:1 채팅?
    if (room.isSingleChat) {
      // 블럭된 회원?
      if (iHave.isBlocked(room.otherUserUid!) == true) {
        return subtitleText(context, T.blockedChatMessage.tr);
      }

      // 상태 메세지 표시?
      if (stateMessageAsSubtitle == true) {
        return UserDoc.field(
          uid: room.otherUserUid!,
          field: Field.stateMessage,
          // 상태 메시지가 있으면 상태 메시지 표시, 아니면 채팅 메시지 표시
          builder: (v) =>
              subtitleText(context, (v == null || v == '') ? text(room) : v),
        );
      }
    }

    return subtitleText(context, text(room));
  }

  Widget subtitleText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 11),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
