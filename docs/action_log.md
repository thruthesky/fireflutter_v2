# 액션 로그

**본 문서는 easy_action_log 로 이동되어야 합니다.**

- 사용자가 앱을 사용할 때 발생하는 특정 활동을 중복없이 기록하는 것이다. 예를 들면, 다른 사용자의 프로필 보기나 채팅방 입장, 글 쓰기, 코멘트 쓰기 등의 해동을 기록하는 것이다.
    - 참고로 중복해서 기록이 필요하다면 활동 기록 기능을 사용하면 된다.
- 액션 로그는 중복없이 한 번만 기록하므로 특정 활동을 하루에 몇 번만 하도록 제한 할 때 사용 할 수 있다.
- 참고로 액션 로그 기능은 활동 기록 기능과 유사한 면이 있고, 데이터가 겹쳐서(같은 데이터가 이중으로) 저장 되기도 한다.

## 개선점

- 현재는 시간 제한 검사를 특정 시간 내에 몇 건의 action 이 존재하는지 검사를 한다.
  예를 들면, 제한을 1시간에 5건의 액션으로 한다면, 1시 10분에 1건, 1시 20분에 1건, 1시 50분에 3건을 했다면, 1시51분 부터는 제한에 걸린다. 그리고 2시 10분이 되면 제한이 1건 해제된다. 그리고 2시 11분에 액션을 1건 하면, 또 제한이 걸리고, 2시 20분에 또 한건 풀린다.
  이것이 사용자 입장에서는 조금 헷갈릴 수 있는데,
  - 날짜별 총량으로 하는 옵션을 둔다.
  이렇게하면, 매일 0시 부터 24시까지 5건으로 제한 할 수 있다. 예를 들어, 1일 23시 59분에 5건을 했다면, 2일 0시 0분에 5건을 또 할 수 있다. 즉, 연속으로 10건을 할 수 있다. 그리고 3일 0시 0분 부터 23시 59분까지 또 최대 5건을 할 수 있는 것이다.
  
## 데이터베이스 설계

- 한번 한 동작을 두 번 카운트하지 않도록 설계한다.
  예를 들면, A 가 B 프로필을 보았다면, 그 이후 A 가 B 의 프로필을 몇 번을 더 보아도, 맨 처음 한번만 기록을 한다.
- `action-logs/<uid>/user-profile-view/<otherUserUid> { createdAt: ... }` 은 다른 사용자 프로필 보기 기록 하는 것이다 처음 한번만 기록하고, 중복 기록을 하지 않는다.
- `action-logs/<uid>/chat-join/<chatRoomId> { createdAt: ... }` 은 채팅방에 접속한 기록이다. 채팅 메시지를 전송하지 않고, 입장만 하면 바로 기록된다. 처음 한번만 기록하고, 중복 기록을 하지 않는다.
- `action-logs/<uid>/comment-create/<post-id>/ { createdAt: ..., postId: ... }` 새 코멘트 기록. 코멘트와 함께 기록을 한다.
- `action-logs/<uid>/post-create/<category>/<post-id>/ { createdAt: ..., category: ... }` 새 게시글 기록. category 와 함께 기록을 한다.
    - 게시판의 경우, category 별로 action 을 저장해서, 각 카테고리 별로 제한을 할 수 있으며,
    - 게시판의 글 쓰기를 하는 경우, 전체 카테고리인 `all` 에 액션 기록을 저장하여 전체 카테고리를 통합해서 제한 할 수 있다.

## 제한 기능 활용

기본적으로 사용자의 특정 액션(예: 프로필 보기 또는 채팅방 입장 등)을 제한 할 때 사용 할 수 있다.

예를 들면, 24시간 이내에 한 사용자가 (기존에 보지 않은) 다른 사용자 프로필을 5명 이상 보지 못하게 막을 수 있다. 즉, 이전에 본 사용자의 프로필은 카운트 하지 않는 것이다.

참고, 글 쓰기와 코멘트 쓰기는 중복 발생하지 않지만, 사용자 프로필 보기와 채팅방 입장은 중복으로 프로필 보기 및 채팅방 입장이 될 수 있는데, 이 때, 최초 한번만 기록한다.

참고, 좋아요는 기록하지 않는다. 좋아요는 좋아요 해제가 있어서, 조금 더 생각을 해 볼 필요가 있다.

### 주의 사항

- 이전에 본 사용자의 프로필을 다시 보기 해도, 카운트가 증가하지는 않는다.
  - 예를 들어, 24시간 동안 3 명의 프로필을 볼 수 있도록 제한을 한 경우, 100 명의 프로필도 볼 수 있다. 단, 신규 사용자(이전에 보지 않았던 사용자)의 프로필은 3 번 밖에 못 본다.
- 다른 사용자 프로필 보기를 1분에 3회로 제한 한 경우, 3회 제한이 걸리면, 이전에 본 다른 사용자의 프로필은 계속 볼 수 있지만, (이전에 보지 않았던) 새로운 프로필은 볼 수 없다.
- 게시 글 생성의 경우, limit 에 걸리면, 글 작성 페이지로 들어가기 전에 미리 사용자에게 알려주는 것이 좋다.
- 채팅방의 경우, 입장을 할 때, action 기록을 한다. 즉, 1분에 2 개로 제한하면, 1분 내에 2번째 입장은 허용한다.


## 로직 설명

- 로직 전체를 이해하지 못하면 코드 접근이 어려울 정도로 난이도가 약간 있습니다. 로직을 잘 이해 해야합니다.

- 먼저 알아 둘 것은 action log 를 DB 에 기록하는 것 자체는 크게 어렵지 않습니다. 그냥 해당 action 이 발생할 때 마다 (중복되지 않게) DB 에 기록을 하는 것입니다.

- 중요한 부분이 action 을 몇 분/시간/일 단위로 제한하는 것인데, 만약 제한을 할 필요없다면, 로직을 이해 할 필요없이 그냥 개발을 계속 진행하면 됩니다.

- Action 제한을 하기 위해서 가장 먼저 해야할 일은 아래와 같이, ActionOption 으로 `ActionLogService.instance.init()` 에 설정을 하는 것입니다.

```dart

final customerInfo = await Purchases.getCustomerInfo();
final active = customerInfo?.entitlements.active.containsKey(gold) == true;
if (active) {
  limit = 999999;
} else if (isGoldFemaleActive) {
 limit = 5;
}
ActionLogService.instance.init(
  userProfileView: ActionLogOption(
    limit: limit,
    seconds: 60 * 60 * 24, // 24 시간
    overLimit: (option) => /** 제한에 걸리면 호출되는 콜백. 알림 메시지 표시 할 것. */,
    debug: true,
  ),
  chatJoin: ActionLogOption(
    limit: limit,
    seconds: 60 * 60 * 12, // 12 시간
    overLimit: (option) => /** 제한에 걸리면 호출되는 콜백. 알림 메시지 표시 할 것. */,
    debug: true,
  ),
);
```

위 코드는 인앱 결제를 한 사용자와 결제를 하지 않은 사용자를 나누어서 사용자 프로필 보기와 채팅방 입장을 할 때 제한을 하는 것입니다. 결제를 했으면, 무제한으로 프로필 보기와 채팅방 이용을 허락하고, 결제를 하지 않았으면, 사용자 프로필을 24시간에 5번, 채팅은 12시간에 5번으로 허용합니다.

만약, 제한을 하지 않고 기록만 한다면 `limit` 값을 무제한으로 주거나, `overLimit` 에서 false 를 리턴하면 됩니다.

- 위와 같이 설정을 하면, 사용자가 해당 action 을 할 때, 적절한 위치에서 제한이 걸렸는지 확인을 합니다.
  - 예를 들면, 사용자 프로필 보기를 할 때에는 `UserService.instance.showPublicProfileScreen()`,
  - 채팅을 할 때에는 `ChatService.instance.showChatRoom()`
  - 글 쓸 때에는 `ForumService.instance.showPostCreateScreen()`
  - 코멘트 쓸 때에는 `ForumService.instance.showCommentCreateScreen()`
  에서 합니다.


- 위의 각 service 들에서 `ActionLogService.instance.Xxxx.isOverLimit()` 을 호출하게 되고 이 함수가 true 를 리턴하면 제한에 걸린것이며 해당 action 을 하지 않습니다. 즉, 이 함수에서 제한을 할지 말지 결정을 하며, false 를 리턴 받으면 계속해서 해당 action 을 수행하는 것입니다.
  - 경우에 따라서, 제한에 걸렸지만, 계속 해당 액션을 수행해야 할 수도 있습니다.

- `ActionLogService.instance.Xxxx.isOverLimit()` 에서 제한에 걸렸지만, 이전에 본 사용자 프로필 보기나 이전에 참여한 채팅방의 경우, 계속해서 동작 할 수 있도록 flase 를 리턴합니다.


- 만약, 프로필 보기, 채팅방 입장, 글 쓰기, 코멘트 쓰기 등의 action 에서 제한이 걸린 경우 결제를 유도하는 paywall 을 보여주거나, 제한에 걸렸다는 표시를 하기 위해서는 `ActionLogOption( overLimit: () { ... })` 에서 paywall 이나 제한이 걸렸다는 화면을 보여주어야 합니다.
  - 혹시, 인앱결제에서 유료 멤버 전용 화면을 보여준다면 적절한 곳에서 절적하게 코딩을 하며 됩니다.





## 코드 설명

다음은 사용자 별로 액션을 제한하는 예제이다.

- `limit` 에는 제한할 회수를 기록한다. 0 의 값을 주면 제한을 하지 않는다. 만약, 3 의 값을 주면, 해당 액션을 세 번만 허용한다.  참고로 이 값이 커지면, DB 에서 그 만큼 많은 데이터를 가져와야 하므로, 성능에 영향을 줄 수 있다. 그래서 최대 100 정도로 설정하는 것이 좋다. 보통 10 이내의 값을 주는 것을 권장한다.
- `seconds` 에는 초 단위 기간을 적어서, 몇 초 동안 제한을 할 것인지를 설정한다. 만약, 10초 동안 3개의 액션을 허용하고 싶다면, limit 은 3, seconds 는 10 이 된다.
- `overLimit` 은 limit 에 걸렸을 경우 추가적인 동작을 수행 할 있는 콜백함수이다. 글 쓰기, 코멘트 쓰기, 채팅방 입장, 사용자 프로필 보기 등에서 적절한 위치에서 각 `ActionLogService` 의 `ActionOption` 으로 지정된, `isOverLimit()` 를 호출한다. 그리고 만약, 이 함수에서 false 를 리턴하면, 해당 액션을 계속 수행한다. 즉, limit 에 걸려도 계속 해서 작업을 수쟁하고자 한다면, 이 함수에서 false 를 리턴하도록 하면 된다. 자세한 것은 로직 설명을 참고한다.
- `debug` 는 로그를 콘솔에 기록한다.

- `ActionLogService.instance.init()` 을 통해서 제한 설정을 하는데, 이 init 함수는 여러번 호출되어도 이전에 설정을 유지한다. 즉, 처음에 init 을 할 때, 사용자 프로필 보기만 제한 했다가, 다시 앱 내의 특정 시점에서 채팅 제한 설정을 추가할 수 있다.

아래의 예제는 사용자 프로필 보기, 채팅, 코멘트 생성을 제한한다. 참고로 글 생성은 빠져있다.

```dart
ActionLogService.instance.init(
  userProfileView: ActionLogOption(
    limit: 5,
    seconds: 10 * 60, // 10분에 최대 5명의 프로필 보기 가능
    overLimit: (option) async {
      toast(
        context: globalContext,
        message: 'You have viewed too many users.',
      );
      // 여기서 만약 false 를 리턴하면, 해당 동작을 제한하지 않고 계속 진행한다.
      return null;
    },
    debug: true,
  ),
  chatJoin: ActionLogOption(
    limit: 5,
    seconds: 60 * 60 * 2, // 2 시간에 최대 5 명과 채팅 가능
    overLimit: (option) async {
      toast(
        context: globalContext,
        message: 'You have entered too many chat rooms.',
      );
      return null;
    },
    debug: true,
  ),
  commentCreate: ActionLogOption(
    limit: 10,
    seconds: 60 * 60, // 1 시간에 최대 10개 코멘트 작성 가능.
    overLimit: (option) async {
      toast(
        context: globalContext,
        message: 'You have commented too many times.',
      );
      return null;
    },
    debug: true,
  ),
);
```

아래의 예제는 사용자의 멤버쉽(글 쓰기 레벨)에 따라서 글 쓰기 회 수를 제한하는 예제이다.

```dart
/// 사용자가 인앱결제를 했으면, Product ID 를 저장.
updateInAppPurchasedEntitlements(CustomerInfo customerInfo) async {
  /// 인앱결제한 Product ID 저장
  final PurchasedEntitlements ids = [];
  for (final entitlementId in EntitlementIDs.values) {
    if (customerInfo.entitlements.all[entitlementId.name] != null &&
        customerInfo.entitlements.all[entitlementId.name]!.isActive) {
      ids.add(entitlementId.name);
    }
  }
  purchasedEntitlements.add(ids);

  /// 인앱결제 구독에 따라서 글 쓰기 회 수 지정
  int limit = 0;
  if (ids.contains(EntitlementIDs.platinum.name)) {
    limit = 10;
  } else if (ids.contains(EntitlementIDs.gold.name)) {
    limit = 5;
  } else if (ids.contains(EntitlementIDs.silver.name)) {
    limit = 1;
  }

  /// 구인구직 게시판과 buyandsell 게시판만 제한하고, 나머지 게시판은 제한하지 않는다.
  ActionLogService.instance.init(
    postCreate: {
      'jobs': ActionLogOption(
        limit: limit,
        seconds: 60 * 60 * 24, // 24시간에 최대 limit 개의 글을 쓸 수 있다.
        overLimit: (option) async {
          toast(
            context: globalContext,
            message: option.limit == 0
                ? '구인 구직 게시판에 글 쓰기 권한이 없습니다.\n멤버쉽 구독을 해 주세요.'
                : '구인 구직 게시판에 ${(option.seconds / 60).toStringAsFixed(0)}분 동안 ${option.limit}개의 글을 쓸 수 있습니다.',
          );
          return null;
        },
        debug: true,
      ),
      'buyandsell': ActionLogOption(
        limit: limit,
        seconds: 60 * 60 * 24, // 24시간에 최대 limit 개의 글을 쓸 수 있다.
        overLimit: (option) async {
          toast(
            context: globalContext,
            message: option.limit == 0
                ? '회원 장터에 글 쓰기 권한이 없습니다.\n멤버쉽 구독을 해 주세요.'
                : '회원 장터에 ${(option.seconds / 60).toStringAsFixed(0)}분 동안 ${option.limit}개의 글을 쓸 수 있습니다.',
          );
          return null;
        },
        debug: true,
      ),
    },
  );
}
```

아래와 같이 전체 게시판 글 쓰기를 제한 할 수 있다.

```dart
ActionLogService.instance.init(
  postCreate: {
    'all': ActionLogOption(
      limit: 3,
      seconds: 60 * 20,
      overLimit: (option) async {
        toast(
          context: globalContext,
          message: '게시판 글 쓰기가 20분에 3회로 제한되어져 있습니다.',
        );
        return null;
      },
      debug: true,
    ),
  },
);
```




- chat join 로그 기록은 `chat.room_body.dart` 의 initState 에서 한다. 기록은 여기서 하지만, over limit 검사는 `chat.service.dart::showChatRoom` 에서 한다.


### 남은 시간 표시


남은 시간은 `ActionLogService.instance.Xxxx.getTimeLeft()` 로 구 할 수 있습니다. 아래와 같이 현재 시간으로 부터 얼마 후 까지 제한되어져 있는지를 표현 할 수 있습니다.


```dart
    timeLeft = await ActionLogService.instance.chatJoin.getTimeLeft();
    print('Time left: $timeLeft');
    final dt = DateTime.now().add(Duration(seconds: timeLeft ?? 0));
    print('Try again at ${DateFormat.jm().format(dt)}');
    jm = DateFormat.jm().format(dt);
```




## 팁

### overlimit 발생하는 경우, 사용자 제한 로직

참고로 글 또는 코멘트 쓰기를 할 때에 over limit 이 발생하는 경우, 그냥 에러 메시지를 표시하거나 결제 창을 보여주면 된다.

다른 사용자의 프로필을 보거나, 채팅방에 입장 하려고 할 때, over limit 이 발생하면 `ActionLogService.instance.isOverLimit()` 에서 이전에 프로필을 보았거나 채팅방에 입장을 했다면, `overLimit` 콜백 자체를 호출하지 않는다. 즉, 사용자는 그대로 프로필 보거나 채팅방에 입장 할 수 있다.

만약 직접 이전에 본 사용자 프로필을 보거나, 채팅방에 입장하는 경우 로직을 만든다면 아래와 같이 하면 된다. 물론 아래와 같이 할 필요 없다. 이미 `ActionLogService.instance.isOverLimit()` 에서, 이전에 본 프로필, 또는 입장한 채팅방의 경우 `overLimit` 콜백 함수 자체가 호출되지 않는다. 그러나 만약, 이 외의 다른 




```dart

    ActionLogService.instance.init(
      userProfileView: ActionLogOption(
        limit: limit,
        seconds: 60 * 60 * 24,
        overLimit: (option) async =>
            my!.isFemale ? false : await _showPaywallOrReachedLimit(option),
        debug: true,
      ),
      chatJoin: ActionLogOption(
        limit: limit,
        seconds: 60 * 60 * 24,
        overLimit: (option) => _showPaywallOrReachedLimit(option),
        debug: true,
      ),
    );
  

  Future<bool?> _showPaywallOrReachedLimit(ActionLogOption option) async {
    if (option.limitUid != null) {
      bool re = await ActionLog.userProfileViewExists(option.limitUid!);
      if (re == true) return false;
    } else if (option.limitRoomId != null) {
      bool re = await ActionLog.chatJoinExists(option.limitRoomId!);
      if (re == true) return false;
    }

    if (globalContext.mounted) {
      if (PurchaseService.instance.isActive) {
        globalContext.push(ReachedLimitScreen.routeName);
      } else {
        globalContext.push(PaywallScreen.routeName);
      }
    }
    return null;
  }
  ```