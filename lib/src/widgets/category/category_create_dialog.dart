import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class CategoryCreateDialog extends StatefulWidget {
  const CategoryCreateDialog({
    super.key,
    required this.success,
    required this.cancel,
  });

  final void Function(Category category) success;
  final void Function() cancel;

  @override
  State<CategoryCreateDialog> createState() => _CategoryCreateDialogState();
}

class _CategoryCreateDialogState extends State<CategoryCreateDialog> {
  final name = TextEditingController();
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Category Name',
            ),
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
            final createdCategory = await CategoryService.instance.createCategory(
              categoryName: name.text,
            );
            widget.success(createdCategory);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}