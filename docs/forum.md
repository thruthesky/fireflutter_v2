# 게시판

**할일: 본 문서는 easy_forum 으로 이동되어야 합니다.**


## 게시판 데이터베이스 구조

- `posts/<category>` 에 앱이 모든 글과 코멘트를 저장해야 한다.
  - `/posts/<category>/<post-id>/comments` 에 앱이 코멘트를 저장해야 한다.

- `post-summaries/<category>` 에는 글 제목, 내용 등 짧은 요약 내용만 저장된다. 직접 여기에 저장 할 필요가 없다. Cloud functions 이 자동으로 저장한다.

- `post-all-summaries` 에는 모든 글이 카테고리 구분없이 저장된다. 카테고리 구분 없이 모든 글을 목록하고자 할 때 사용 할 수 있다.

- 참고로, summary 는 cloud function 이 자동으로 저장하므로 앱에서 저장 할 필요 없다.
- 참고로 summary 는 최대 64 글자의 제목과 128 자의 내용, category, id, uid, createdAt, order 등이 저장된다. `no of like` 나 `no of comments` 는 저장되지 않는다. 필요한 필드 값이 있다면, `posts/<category>/<id>` 에 해당 필드만 읽으면 된다. 전체를 다 읽을 필요가 없다.



## Coding Guideline


- 일반적으로 게시판 카테고리를 임의로 지정하는 것이 아니라, 데이터베이스에 카테고리를 생성하고 그 카테고리가 존재하는 경우에만 글을 작성하게 하는 경우가 흔하다. 그리고 DB 의 카테고리에는 해당 카테고리에 대한 이름이나 설명, 관리자, 글 쓰기 가능한 사용자 등급 등 각종 설정을 할 수 있도록 하는 것이다. 하지만, FireFlutter 에서는 이 카테고리를 따로 DB 에 저장하지 않아도 동작 할 수 있도록 했다. 이렇게 하는 가장 큰 이유는 DB 구조의 간편함을 유지하기 위한 것이다.

- 글 데이터에 저장되는 `category` 는 DB 내에 미리 정해져 있거나 관리자 모드에서 따로 카테고리를 생성할 필요 없이 그냥 카테고리 문자열을 적절히 (임의로) 지정해서 쓰면 된다. 예를 들어, `abc` 라는 카테고리가 없는데, 그냥 글 쓰기 할 때, 카테고리에 `abc` 라고 저장하고, 글 목록을 할 때, 카테고리를 `abc` 로 해서 목록하면 된다.

- `category` 카테고리 값은 변경 할 수 없다. 이것은 RTDB 의 경로 구조와 문제가 있는데, `/posts` 경로 뿐만아니라 `/post-summary`, `post-all-summary` 등 여러 경로가 복잡하게 얽혀 있어서 그렇다.






## Observing post changes and update data

As you know, we are using realtime database. This means the app should observe for data change as small portiona as it can be. And we made it simple for post data changes. Use `Post.onFieldChange(field, callback)`.

The example below listens the title changes and if it is changed, it wil update on screen.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: post.onFieldChange(Field.title, (v) => Text(v ?? '')),
    )
  );
}
```

## Test code

You can load a post like below and do whatever test.

```dart
SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  Timer(const Duration(microseconds: 200), () async {
    final post = await Post.get(category: 'discussion', id: '-No5q8HHMw7ZDZSjR-Qu');
    print('length of comment; ${post?.comments.length}');
    for (final c in post?.comments ?? []) {
      print("[${c.depth}] ${c.content}");
    }
  });
});
```

## Comments

Refer to [Comment doc](comments.md).

## Posts

Refer to [Post doc](post.md).

## 푸시 알림 구독

게시판 카테고리 별 푸시 알림 구독과 해제는 아래와 같이 하면 된다. 보다 자세한 코드는 아래의 `CategorySubscriptionIcon` 위젯 소스 코드를 보면 된다.

```dart
CategorySubscriptionIcon(
  category: Categories.menus[index].id,
)
```


