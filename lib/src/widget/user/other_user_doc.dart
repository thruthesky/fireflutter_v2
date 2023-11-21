import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// MyDoc
///
/// myDoc is a wrapper widget of UserDoc widget.
class UserLiveDoc extends StatelessWidget {
  const UserLiveDoc({super.key, required this.uid, required this.builder});

  final Widget Function(User) builder;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: UserService.instance.snapshotOther(uid),
      builder: (context, snapshot) => buildStreamWidget(context, snapshot),
    );
  }

  Widget buildStreamWidget(BuildContext _, AsyncSnapshot<User?> snapshot) {
    /// 주의: 로딩 중, 반짝임(깜빡거림)이 발생할 수 있다.
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SizedBox.shrink();
    }

    final userModel = snapshot.data;

    /// if snapshot has no data (when connection state is no longer waiting), it means, there is no data in firestore even if the user has logged in.
    /// Or if the userModel is null, it means, the app just started and the user has not logged in yet or in the middle of login.
    ///
    /// In these case, a user object with exists=false is passed to the builder.
    if (snapshot.hasData == false || userModel == null) {
      ///
      /// It passes the user model with the current time when there is no user document.
      return builder(User.nonExistent());
    }
    return builder(userModel);
  }
}