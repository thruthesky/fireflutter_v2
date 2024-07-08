# Push Notifications

## FCM and Tokens

Fireflutter uses FCM to send messages to devices.

The tokens are saved under `/user-fcm-tokens/<token> { uid: [user uid], platform: [android or ios]}`. So, if you want to get the tokens of a user, you must get the tokens by searching the uid.

## Subscription

Messages are sent to each user token individually without using topics. Therefore, information about whether a user is subscribed or not needs to be stored in the database. Please refer to the documentation for each feature.
Refer to: Board Subscription
Refer to: Chat Room Subscription

## Sending messages to user

One user may use multiple devices and one device may have multiple tokens. So, if the app sends a message to A, the app must query to get the tokens of A in `/user-fcm-tokens`

The code below shows how send a message to multiple users.

```dart
final List<String> uids = some.users;

//sending notification to the list of uids
await MessagingService.instance.sendTo(
  uids: uids,
  title: '... message title ...',
  body: '... message body ...',
  image: url,
);
```

To use this method, The firebase cloud function named `sendPushNotifications` in `firebase/functions/src/messaging/functions.ts` must be installed. See installation on how to install firebase functions.

## Sending messages for forum category subscription and chat room subscription

There are firebase cloud functions that work with Fireflutter for sending messages to subscribers on forum categories and chat rooms.

You will need to install `sendMessagesToCategorySubscribers` and `sendMessagesToChatRoomSubscribers` in `firebase/functions/src/messaging/functions.ts` to make it work.

The source code is under `firebase/functions` and the test code is under `firebase/functions/tests`.

## Unit testing

See `firebase/functions/tests` folder for unit testing on push notification. To run the unit test code, you need to set the environment variable - `GOOGLE_APPLICATION_CREDENTIAILS`

## Opening Screen When Message is Tapped in System Tray

When a user taps on a message in the system tray, the app should open pages such as chats, posts, or user profiles.

Internally, when a message is tapped, the push notification data is modeled through parseData.

The screen to which the push notification message is routed will vary depending on each app. You can refer to the example below and modify it accordingly for your use case.

```dart
Future<void> _onMessageTapped(RemoteMessage message) async {
  dog("onMessageTapped trigged.");
  dog("onMessageTapped: ${message.data.toString()}");

  final data = MessagingService.instance.parseData(message.data);

  if (data is ChatMessagingModel) {
    ChatService.instance.showChatRoom(
      context: globalContext,
      roomId: data.roomId,
    );
    return;
  }

  if (data is PostMessagingModel) {
    Post? post =
        await Post.get(category: data.category, id: data.id);
    if (post == null) return;
    if (globalContext.mounted) {
      ForumService.instance.showPostViewScreen(
        globalContext,
        post: post,
      );
    }
    return;
  }

  if (data is UserMessagingModel) {
    UserService.instance.showPublicProfileScreen(
      context: globalContext,
      uid: data.uid,
    );
    return;
  }
}
```

