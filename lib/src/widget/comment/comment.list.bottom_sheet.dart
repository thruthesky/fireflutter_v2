import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// Comment List Bottom Sheet
///
/// This widget shows the comment list of the post in a bottom sheet UI style.
/// Use this widget with [showModalBottomSheet].
class CommentListBottomSheet extends StatelessWidget {
  const CommentListBottomSheet({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      // margin: const EdgeInsets.symmetric(horizontal: sizeSm),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 28,
            margin: const EdgeInsets.symmetric(vertical: sizeMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondary.withAlpha(80),
            ),
          ),
          Expanded(
            child: CommentOneLineListView(post: post),
          )
        ],
      ),
    );
  }
}