import 'package:fireflutter/src/model/chat/room.dart';
import 'package:flutter/material.dart';

class ChatRoomCreateDialog extends StatefulWidget {
  const ChatRoomCreateDialog({
    super.key,
    required this.success,
    required this.cancel,
  });

  final void Function(Room room) success;
  final void Function() cancel;

  @override
  State<ChatRoomCreateDialog> createState() => _ChatRoomCreateDialogState();
}

class _ChatRoomCreateDialogState extends State<ChatRoomCreateDialog> {
  final name = TextEditingController();
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Chat Room'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Chat Room Name',
            ),
          ),
          CheckboxListTile.adaptive(
            title: const Text('Open Chat'),
            value: isOpen,
            onChanged: (re) => setState(() {
              isOpen = re!;
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.cancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final createdChatRoom = await Room.create(
              name: name.text,
              open: isOpen,
            );
            widget.success(createdChatRoom);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}