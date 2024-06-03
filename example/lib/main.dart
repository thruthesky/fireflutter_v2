import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example/app.localization.dart';
import 'package:example/firebase_options.dart';
import 'package:example/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

zoneErrorHandler(e, stackTrace) {
  dog("---> zoneErrorHandler; runtimeType: ${e.runtimeType}");
  if (e is FirebaseAuthException) {
    toast(
        context: globalContext,
        message: '로그인 관련 에러 :  ${e.code} - ${e.message}');
  } else if (e is FirebaseException) {
    dog("FirebaseException :  $e }");
  } else if (e is FireFlutterException) {
    dog("FireFlutterException: (${e.code}) - ${e.message}");
    error(context: globalContext, message: e.message);
  } else {
    dog("Unknown Error :  $e");
  }
  debugPrintStack(stackTrace: stackTrace);
}

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      runApp(const ChatApp());

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
      };
    },
    zoneErrorHandler,
  );
}

class ChatApp extends StatefulWidget {
  const ChatApp({
    super.key,
  });

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  @override
  void initState() {
    super.initState();

    //
    UserService.instance.init();
    AdminService.instance.init();
    initFirstInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    dog('chat admin uid: ${AdminService.instance.chatAdminUid}');

    /// set the default locale base from device system language
    setIntlDefaultLocale(context);

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.locales,
    );
  }

  /// Run code on the first internet connection
  ///
  /// It initializes the messaging service when the first internet connection is established
  /// to avoid `firebase_messaging/unknown] Internet connection is not available` error.
  /// 인터넷 연결 Subscription
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  initFirstInternetConnection() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) {
      dog('connectivityResult: $connectivityResult');

      /// Is the internet connection available?
      if (connectivityResult.contains(ConnectivityResult.none) == false) {
        /// Then, run this code only one time on the first internet connection.
        connectivitySubscription?.cancel();
        dog('initConnectivity: Internet connection is available. Continue to init MessagingService.');
        MessagingService.instance.init(
          onBackgroundMessage: (RemoteMessage message) async {},
          onForegroundMessage: (RemoteMessage message) {},
          onMessageOpenedFromTerminated: (RemoteMessage message) {},
          onMessageOpenedFromBackground: (RemoteMessage message) {},
          onNotificationPermissionDenied: () {
            dog("onNotificationPermissionDenied()");
          },
          onNotificationPermissionNotDetermined: () {
            dog("onNotificationPermissionNotDetermined()");
          },
        );
      }
    });
  }
}
