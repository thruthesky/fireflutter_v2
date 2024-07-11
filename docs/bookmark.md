# 북마크

**할일: 본 문서는 easy_bookmark 로 이동되어야 합니다.**


- 북마크는 `좋아요`와는 다르게 나중에 다시 보고 싶은 정보를 저장 해 놓는 것이다.
- 북마크는 즐겨찾기 또는 Favorite 과 같은 의미이다.
- `/bookmarks/<로그인_사용자_UID>/<Target_UID>` 와 같이 저장된다.
- 값에
    - otherUserUid 가 들어가 있으면, 사용자 북마크
    - category 가 있으면 글 북마크
    - commentId 가 있으면 코멘트 복마크이다.
    - 채팅방은 북마크를 하지 않는다.

- 북마크와 북마크 해제는 `Bookmark.toggle()` 을 사용하면 된다.

## 북마크 목록

아래는 북마크 기본 코드이며, 필요한 경우, `BookMarkListView` 를 복사해서 수정해서 사용하면 된다.

```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  static const String routeName = '/Bookmark';
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const BookmarkListView(),
    );
  }
}
```
