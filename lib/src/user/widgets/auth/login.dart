import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// The user has logged in Firebase and the UID is ready.
///
/// Firebase Auth 에 로그인을 한 경우, builder(uid) 가 실행된다.
/// 만약, 로그인을 하지 않은 상태이면, notLogin() 이 실행된다.
///
/// 참고로, Firebase Realtime Database 의 사용자 문서가 로딩되지 않아도, Firebase Auth 에
/// 로그인이 되면 이 함수의 builder 가 실행된다.
///
/// [yes] 옵션이며, 로그인이 되면 실행되는 콜백 함수. 사용자 UID 가 전달됨. 옵션 함수로 생략되면, 로그인을 한 경우 아무것도 표시되지 않는다.
///
/// [no] 로그인이 되지 않으면 실행되는 함수. 옵션 함수로 생략되면, 로그인이 되지 않은 경우 아무것도 표시되지 않음.
///
/// [loadingBuider] 로그인 상태를 확인하는 중에 실행되는 함수.
class Login extends StatelessWidget {
  const Login({
    super.key,
    this.yes,
    this.no,
    this.loadingBuider,
  });

  final Widget Function(String)? yes;

  final Widget Function()? no;
  final Widget Function()? loadingBuider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: FirebaseAuth.instance.authStateChanges().map((user) => user?.uid),
      initialData: myUid,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return yes?.call(snapshot.data!) ?? const SizedBox.shrink();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingBuider?.call() ??
              const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return no != null ? no!() : const SizedBox.shrink();
      },
    );
  }
}
