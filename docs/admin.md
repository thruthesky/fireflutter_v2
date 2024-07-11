# 관리자


**할일: 본 문서는 easy_admin 로 이동되어야 합니다.**


## 개요

- 관리자 기능은 사용자, 글, 코멘트, 사진 등등을 관리 할 수 있게 해 준다.
 
- 참고로, 앞으로는 Firestore 콘솔을 열지 않고, 앱 내에서 선착순 1명이 루트 관리자가 되고, 루트 관리자가 다른 사용자를 관리자로 지정할 수 있도록 할 계획에 있다.

## 초기화

- 별다른 초기화가 필요없다.


### 관리자로 지정하기

- 파이어베이스 콘솔에서 Firestore 를 열어서, 관리자로 지정하고자 하는 사용자 문서의 admin 필드에 true 값을 주면 된다.
- 관리자는 여러명 지정 할 수 있다. 원하는 사용자 마다, Firestore 콘솔에서 해당 사용자의 문서에 `admin` 필드 값으로 true 를 주면 된다.

- 향후, 클라우드 함수를 통해서, 관리자가 지정된 사용자 없다면, 최초 1회 선착순 관리자로 지정을 할 수 있도록 한다.


## 관리자 권한

참고: Firestore Security Rules 에 대해 자세한 설명은 [하우스 엔진 - Firestore Security Rules](https://github.com/thruthesky/hengine?tab=readme-ov-file#firebase-security-rules) 항목을 참고한다.



## 관리자 인지 확인하기

- 본인이 관리자인지 아닌지는 `im.admin` 으로 확인을 할 수 있으며,

- DB 가 변경되어 로그인한 사용자가 갑자기 관리자로 임명된다고 해도, Stream 으로 실시간으로 변하지 않도록 한다. 왜냐하면 관리자 지정 또는 변경이 극히 드물게 변경하므로, 굳이 실시간 변경까지는 할 필요 없다.

```dart
/// 여기서 부터...
```



--- TODO 여기서 부터 관리자와 채팅하는 설명을 진행한다. ----

## 관리자와 채팅하기

- 참고로, 관리자와 채팅을 하면, 자동으로 푸시 알림 메시지가 관리자에게 전달된다.

- `AdminService.instance.chatAdminUid` 에 채팅을 전담하는 관리자 UID 가 들어가 있다. 그래서 관리자와 채팅을 하기 위해서는 아래와 같이 하면 된다.

```dart
final room = ChatRoom.fromUid(AdminService.instance.chatAdminUid!);
ChatService.instance.showChatRoomScreen(roomId: roomId);
```

- 관리자과 대화창(1:1 채팅방)을 열지 않고, 곧바로 채팅 메시지를 보내기 위해서는 아래와 같이 하면 된다.

```dart
ChatModel chat = ChatModel(
  room: ChatRoom.fromUid(AdminService.instance.chatAdminUid!),
);
await chat.room.join();
await chat.room.reload();

chat.sendMessage(
  text: text,
  force: true,
);
```

- 관리자 중에서는 고객 상담(앱내 문의)을 전담하는 채팅 상담사가 있어야 한다. 그러한 상담 관리자는 `admins/{uid: ['chat']}` 과 같이 `chat` 옵션을 추가해서 저장을 한다. 단 주의 할 것은 chat 옵션을 가진 관리자는 1명 이어야만 한다.
  - 참고로, Firebase console 에서 처음 admins 데이터를 생성 할 때, Realtime Database 에서 `+` 버튼을 클릭하고 키는 `admins`으로 하고 값은 `{"FjCrteoXHgdYi6MjRp09d51F71H3": "chat"}` 로 하고, Type 은 `auto` 로 하면 된다.
  




## 관리자 화면



- `AdminService.instance.showDashboard()` 를 호출하면 FireFlutter 에서 제공하는 기본 관리자 화면이 나온다.




## 관리자 관련 위젯


내가 관리자인지 아닌지 알기 위해서는 `Admin` 위젯을 사용하면 된다.

로직에서 관리자인지 알기 위해서는 `isAdmin`, `isRootAdmin` 등의 글로벌 변수를 사용하면 된다.
