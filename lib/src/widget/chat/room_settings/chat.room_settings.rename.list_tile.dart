import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class ChatRoomSettingsRenameListTile extends StatelessWidget {
  ChatRoomSettingsRenameListTile({
    super.key,
    required this.room,
  });

  final Room room;

  final chatRoomName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    chatRoomName.text = room.rename[myUid] ?? '';
    return ListTile(
      title: const Text("Rename Chat Room"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("This will rename the chat room only on your view."),
          TextFormField(
            controller: chatRoomName,
            textInputAction: TextInputAction.done,
            decoration:
                const InputDecoration(hintText: 'Enter the chat room name.'),
            onFieldSubmitted: (value) async {
              await ChatService.instance.updateMyRoomSetting(
                  room: room, setting: 'rename', value: value);
            },
          ),
        ],
      ),
    );
  }
}
