# 글

**할일: 본 문서는 easy_forum 으로 이동되어야 합니다.**



- 글 목록을 할 때에는 주로 카테고리 별로 목록을 하게 된다.

- 이 때, 카테고리는 따로 DB 에 기록하지 않는다. 즉, 원하는데로 만들어 쓸 수 있다. 예를 들어 `abc` 라는 카테고리를 쓰고 싶다면 그냥 글 작성 할 때, 카테고리를 `abc` 로 저장하고, 글을 보여줄 때 카테고리를 `abc` 로 하면 된다. 이렇게 하면 편리하게 카테고리를 쓸 수 있지만, 카테고리별 설정을 할 수 없게 된다. 예를 들면, 카테고리 관리자 설정이나 부 관리자 설정, 카테고리 별 이름, 설명 등을 기록하지 못해 설정이 어렵다.
  - 권한 문제는 글 CRUD 훅을 통해서 충분히 해결이 가능하고,
  - 카테고리를 따로 DB 에 저장하지 않으므로 발생하는 모든 문제는 충분히 해결 가능하다.


## 글 데이터베이스 구조

주의 할 것은 글은 여러 경로에 저장되며, 필드가 서로 다를 수 있다. 예를 들면, cloud functions 에서 무제한 update loop 에 빠지지 않게 하기 위해서, `posts` 노드에는 값을 업데이트 하지 않을 수 있다.

- `posts/<category>/<postId>` 에 모든 글 데이터가 카테고리별로 저장되는데, 글 정보 전체를 가져와 보여줄 때 쓴다. 예를 들면 글 읽기 화면에서 사용한다.
- `posts-summaries/<category>/postId>` 에, 글 요약 정보가 카테고리 저장되는데, 제목과 내용을 짧게 저장한다. 글 목록에서 주로 사용한다.
- `posts-all-summaries/<postId>` 모든 글의 요약 정보가 카테고리 구분없이 저장된다. 주로, 글 내용을 목록할 때, 카테고리 구분없이 화면에 표시할 때 사용한다.

- 주의, 글 데이터에 `category` 는 저장하지 않는다.
- `title` 제목
- `content` 내용
- `uid` 글 쓴이
- `createdAt` 글 쓴 시간. 오른차순
- `order` 글 쓴 시간. 역순
- `likes` 좋아요. 데이터는 map 타입이며, `{uid: true}` 와 같이 저장된다.
- `noOfLikes` 좋아요 할 때 같이 업데이트되는 변수이다. 이 변수는 클라이언트에 의해서 저장된다.
- `urls` 사진 URL 배열
- `noOfComments` 코멘트가 작성될 때, 백엔드에서 저장(증가)를 시킨다.
- `deleted` 글이 삭제되면 true.


- `group` 은 글의 그룹이다. `group` 은 모든 카테고리 구분 없이 글의 그룹을 만든다. 즉, `group` 이 대 카테고리, `category` 가 소 카테고리로 생각을 하면 된다. 이 값은 옵션이며, 글 생성 할 때, 저장하면 백엔드에서 `posts-summaries` 와 `posts-all-summaires` 에 저장을 한다.
  활용 예를 들면, meetup 게시판글은 빼고 목록을 하고자 한다면, 게시판 글 쓰기를 할 때, 특정 그룹을 주고 그 그룹으로 목록하면 된다.
  참고로, meetup 게시글은 자동으로 meetup 그룹이 들어간다.

- `group_order` 글 데이터에 그룹별 시간 목록 값이다. 백엔드에서 `posts-summaries` 와 `posts-all-summaries` 에만 저장하며, `posts` 노드에는 저장되지 않는 값이다.
  이 값은 `group` 의 값에 `order` 을 더한 값을 가진다. 예를 들어, group 이 community 이고 order 값이 -1234 이면, group_order 의 값은 "community-1234" 가 되며, 적절하게 order by, start at, end at, limit 을 통해서 원하는 값을 가져오면 된다.
  참고로, `PostListView` 와 `PostLatestListView` 가 기본적으로 group 정렬을 지원한다.
  

- `photoOrder` 사진이 등록된 경우, 글의 `order` 값이 저장된다. 즉, 특정 카테고리에서 사진이 있는 최근글을 추출 할 수 있다.





## 글 목록


글 목록은 `PostListView`, `PostAllListView`, `PostLatestListView` 등 여러가지가 있다.


### PostListView - 카테고리 별 게시판 목록

카테고리 별 글 목록을 할 때 사용하는 위젯이다. 무한 스크롤을 통해서 글을 보여준다.

```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:silvers/defines/categories.dart';

class PostListScreen extends StatelessWidget {
  static const String routeName = '/PostList';
  const PostListScreen({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Categories.getLabel(context, category)),
        actions: [
          IconButton(
            onPressed: () {
              ForumService.instance
                  .showPostCreateScreen(context, category: category);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PostListView(
        category: category,
      ),
    );
  }
}
```




#### 글 쓰기 UI 변경

디자인 작업은 하기 나름이다. FireFlutter 에서는 기본적인 디자인만 추가하며 Flutter 의 theme 작업 방식으로 모든 디자인 작업을 변경 할 수 있다.

아래의 예제는 간단히 UI 디자인을 변경하는 기본 예제이다.

```dart
ListTileTheme( // 기존 ListTile 테마를 모두 삭제
  child: PostListView( // 글 목록은 ListView 에 표시하며, ListView 의 옵션 사용 가능.
    category: 'qna',
    padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
    pageSize: 20,
    separatorBuilder: (p0, p1) => Padding( // 각 ListTile 중간에 라인 추가
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 5,
        thickness: 1,
        color: context.outline.withAlpha(64),
      ),
    ),
  ),
),
```

#### itemBuilder 를 통한 전체 UI 커스텀 디자인

`itemBuilder` 를 통해서 글 목록에서 글 UI 표현을 마음데로 작업 할 수 있다.


#### 글 목록 그리드뷰로 표시하기

- 아래의 방식으로 GridView 로 게시글을 표시 할 수 있으며 주로 사진첩(갤러리) 방식으로 사진 위로 리스트를 할 때 사용하면 된다.
- 참고로 `PostListView.gridView` 는 `GridView.builder` 의 모든 옵션을 다 지원한다.


```dart
PostListView.gridView(
  category: widget.club.id,
  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
  pageSize: 20,
),
```


다음의 예는 글 목록을 그리드 형태로 표현하는 것인데, 각 아이템의 UI (radius 등) 를 수정하고, 또 한 행에 3개의 글(아이템)이 보이도록 하는 예제이다. 이 처럼 많은 것들을 원하는 데로 디자인을 할 수 있다.

```dart
PostListView.gridView(
  category: '${widget.club.id}-gallery',
  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
  itemBuilder: (post) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: PostCard(post: post),
  ),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  emptyBuilder: () => const Center(child: Text('사진을 등록 해 주세요.')),
),
```


## 글 읽기

아래와 같이 글 읽기 화면을 열면 된다.

```dart
ForumService.instance.showPostviewScreen(context: context, post: post)
```


참고로 글 읽기 화면에서 코멘트 목록과 코멘트 입력을 없애고, 오직 글 정보만 보여주고 싶다면 아래와 같이 commentable 옵션을 false 로 하면 된다. 그러면 해당 글에는 코멘트도 볼 수 없으며, 코멘트를 쓸 수도 없다. 코멘트가 필요없는 경우 사용을 하면 된다.

참고로 `commentable: false` 옵션은 채팅형 게시판에서 사용된다. 참고, 본 문서의 채팅형 게시판

```dart
ForumService.instance.showPostViewScreen(
    context: context,
    post: post,
    commentable: false,
  ),
```









## 글 쓰기

글 쓰기는 아래와 같이 할 수 있다.

```dart
OutlinedButton(
  onPressed: () => ForumService.instance.showPostCreateScreen(
    context: context,
    category: widget.club.id,
  ),
  child: const Text('글 쓰기'),
),
```



### PostAllListView 전체 게시판 목록

카테고리 별로 게시글을 보여주는 것이 아니라, 모든 카테고리의 글을 한번에 무한 스크롤 목록으로 보여주고 싶을 때 사용한다.






### PostLatestListView - 최근 글 목록 가져오기


최근 글을 가져오려면 `PostLatestListView` 를 사용할 수 있으며, 필요에 따라서 소스 코드를 복사하여 적절히 수정해서 사용하면 됩니다.


아래의 예제는 `PostTitle` 위젯을 통해 제목만 출력한다.

```dart
PostLatestListView(
    category: 'qna',
    limit: 5,
    itemBuilder: (post) => PostTitle(post: post)),
```

아래는 `PostListTile` 위젯을 통해 목록에 적당한 UI 로 글 정보를 출력한다.

```dart
PostLatestListView(
    category: 'qna',
    limit: 5,
    itemBuilder: (post) => PostListTile(post: post)),
```


참고로, PostListTile 을 보다 작게(또는 tight 하게) 표시하고자 한다면, `PostListTile.small()` 을 사용하면 된다. 다른 모든 옵션은 동일하며, `small` 네임드 생성자를 사용하면 된다.

```dart
PostListTile.small(post);
```





참고로, `PostLatestListView` 는 ListView 의 모든 옵션을 지원하며, GridView 도 같이 지원한다.

```dart
const Text('최근 사진들'),
PostLatestListView.gridView(
  category: '${club.id}-gallery',
  emptyBuilder: () => const Card(child: Text('최근 사진이 없습니다.')),
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
),
const Text('최근글'),
PostLatestListView(
  category: club.id,
  emptyBuilder: () => const Card(child: Text('최근 글이 없습니다.')),
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
),
```



아래의 예제는 하나의 화면에 질문과 답변, 자유게시판의 카테고리들에서 최근글 몇개를 가져와 보여주는 예제이다.

```dart
class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            ...['qna', 'discussion'].map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push(
                      PostListScreen.routeName,
                      extra: {
                        Field.category: category,
                      },
                    ),
                    child: Text(category.toUpperCase()),
                  ),
                  PostLatestListView(
                      category: category,
                      limit: 5,
                      itemBuilder: (post) => PostListTile(post: post)),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
```




## 채팅형 게시판

게시판인데 채팅방 처럼 보이게 디자인을 할 수 있다. 아래와 같이 하면 마치 채팅방 처럼 보이고 채팅방 처럼 동작한다.


```dart
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:philov/etc/functions.dart';
import 'package:philov/etc/translations/app.translations.dart';

class ForumChatScreen extends StatelessWidget {
  static const String routeName = "/forum-chat-screen";
  const ForumChatScreen({super.key});

  String get category => isDebugMode() ? 'test-buyandsell' : 'buyandsell';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(At.forum.buyandsell.tr)),
      resizeToAvoidBottomInset: false,
      body: PostListView(
        reverse: true,
        category: category,
        itemBuilder: (post, index) => PostBubble(post: post),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ForumChatInput(category: category),
      ),
    );
  }
}
```