# 스타일 가이드


스타일 간이드란 일종의 코딩 스타일(컨벤션)을 말하는데, 많은 개발자들이 협업할 때, 통일된 방식의 코드를 작성하여 가독성을 높이고자 하는데에 있다. 한 마디로 규칙에 맞게 코드를 작성하라는 것이다. 그리고 그 규칙이란 가장 표준스러운 규칙이어야 할 것이다.


## 테스트

테스트 코드를 작성하는 것은 절대적으로 중요하지만, 플러터에서 테스트를 하는 것이 만만치 않아서, 처음 부터 테스트 코드 작성을 요구한다면 개발 참여에 큰 장벽이 될 것이다. 그래서 버그 레포팅, 에러 수정, 문서 업데이트 등에서는 테스트 코드를 작성하지 않아도 된다. 하지만 핵심이 되는 중요한 기능을 작성 또는 수정하는 경우에는 반드시 테스트를 해야 한다.

테스트에 관한 자세한 내용은 [테스트 항목](./test.md)을 참고한다.

## 문서화

문서화는 두 가지가 있다.

- 소스 코드에 코멘트로 작성하는 것은 주로 소스 코드 그 자체에 대한 설명만 하며, pub.dev 의 API Reference 에 자동으로 적용된다. 따라서 여러분들 중에서 소스 코드의 코멘트에 오류가 있거나 보강할 내용이 있으면 적극적으로 Fork 후 수정하여 PR 해 주면 된다.
- Markdown 파일에 전반적인 본 패키지의 이용 방법에 대한 설명을 작성하는 데, `<project-folder>/docs` 폴더에 작성하면 된다. 이 Markdown 설명서는 `MkDocs` 에 의해서 자동으로 웹사이트로 업데이트 된다.
- 

## 코드는 무조건 짧아야 한다.

- 코드는 무조건 짧아야 한다. 그래야 단순하다. 단순해야 읽기 쉽다.
- 긴 코드는 무조건 삭제되어야 한다. 코드가 길거나 복잡하면 코드 리뷰 reject 될 가능성이 매우 높다.

## 함수명과 변수명

- 짧은 코드를 쓰기 위해서는 함수명과 변수명이 매우 중요하다. 특히, 개발자는 소스 코드를 바탕으로 서로의 생각을 이해할 수 있어야 한다. 이 때, 함수명과 변수명은 코드를 읽어 나가는데 매우 중요한 역할을 한다.



### 플러터스러움

- Dart & Flutter 코딩 스타일 가이드를 따르며,
- Flutter 컨벤션을 따른다. 예를 들면, 많은 라이브러디르에서 `Xyz.instance` 와 같이 Singleton 사용 방식을 그대로 따라 한다. 또 다른 예로 `ListView.builder` 와 같이 named contructor 를 많이 사용하는데, 그러한 방식을 그대로 따라서 한다. 모델링, 상태관리, 이벤트 등 많은 부분에서 가장 플러터스러운 코드를 작성하도록 한다.
- 당연하겠지만 dart style guide 와 flutter style guide 를 따라서 작업을 해야 한다. 그래야 개발자들 끼리 소스 코드를 바탕으로 쉽게 소통 할 수 있는 것이다.


### 상태관리

- Firebase 를 쓰면서 상태 관리를 따로 하는 것은 낭비이다.
- 그럴리는 없겠지만, 만약, 상태 관리가 조금이라도 필요하다면 직접 상태관리자를 만들어 쓴다.



### 모델

- 모델은 각 데이터의 분류에 따라 만들어 진다. 예를 들면 사용자는 User, 게시판 카테고리는 Category, 게시글은 Post, 코멘트는 Comment, Chat, ChatRoom, ChatMessage, Report 등등으로 나뉜다.
- 모델은 데이터를 모델링하는 serialize/deserialize 기능 뿐만이나, 기본적인 CRUD 및 동작 기능을 가지고 있다.
    - 즉, 해당 Entity 의 데이터 관리 뿐만아니라 MVC 모델에서 Model 이 하는 business logic 까지 포함된다. 단, 이 business logic 은 해당 Entity 에 대한 것으로 제한을 한다. 예를 들면,
        - `user.like()`, `post.like()`, `comment.like()` 와 같은 공통되고 통일성이 있는 로직 부터, `User.create()`, `user.update()`, `user.resign()`, `user.follow()`, `user.block()` 등 해당 Entity 의 다양한 로직을 가지고 있다.



### 서비스

- 서비스는 모델에서 제공하지 않는 기능을 담는다.
- 서비스는 `FirebaseAuth.instance` 와 같은 방식의 Singleton 으로 사용하며
- 예를 들어, 사용자의 아바타를 터치(클릭)했을 때, 사용자의 프로필을 화면에 띄워야 한다. 그런데 사용자의 아바타는 글, 코멘트, 채팅 뿐만아니라 앱의 구조에서 깊숙한 곳에서 다양한 방식으로 표시될 수 있다. 또한 본 패키지를 사용하는 개발자가 임의의 위치에 아바타를 표시 할 수 있다. 이 때 사용자의 프로필을 화면에 띄우는 로직을 매번 코딩해야한다면 번거롭기도 하며 실수로 에러가 날 수 있고, 또 해당 로직이 변경되면, 모든 아바타를 쓰는 곳에 일일히 변경을 해 주어야 한다. 그래서 사용자 프로필을 여는 로직을 함수로 만들어 놓아야하는데, 그러한 함수를 모델 별로 묶어 놓은것이 서비스이다.
- 서비스에는 UserService, CategoryService, PostService, CommentService 등과 같이 있으며 공통적인 루틴이 있다.

