import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// PostTitle
///
/// Display the title of a post.
class PostTitle extends StatefulWidget {
  const PostTitle({super.key, required this.post});

  final Post post;

  @override
  State<PostTitle> createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  /// 내용을 캐시해서, 깜빡이지 않도록 한다.
  late String title;
  @override
  void initState() {
    super.initState();
    title = widget.post.title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: widget.post.onFieldChange(
        Field.title,
        (v) {
          title = v ?? '';
          return _text();
        },
        onLoading: _text(),
      ),
    );
  }

  _text() {
    return Blocked(
      otherUserUid: widget.post.uid,
      no: () => Text(title),
      yes: () => Text(T.blockedTitleMessage.tr),
    );
  }
}
