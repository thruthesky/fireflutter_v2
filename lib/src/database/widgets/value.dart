import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

/// Value
///
/// Rebuild the widget when the node is changed.
///
/// [path] is the path of the node.
///
/// [builder] is the widget builder.
///
/// [onLoading] is the widget to show when waiting for the data.
///
/// Example: below will get the snapshot of /path/to/node
///
/// ```dart
/// Value(path: 'path/to/node', builder: (value) {
///  return Text(value);
/// });
///
class Value extends StatelessWidget {
  const Value({
    super.key,
    required this.path,
    required this.builder,
    this.onLoading,
  });

  final String path;

  /// [dynamic] is the value of the node.
  /// [String] is the path of the node.
  final Widget Function(dynamic value) builder;
  final Widget? onLoading;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref(path).onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> event) {
        if (event.hasData) {
          return builder(event.data!.snapshot.value);
        }
        if (event.connectionState == ConnectionState.waiting) {
          print("Wait again");
          return onLoading ?? const SizedBox.shrink();
        }
        if (event.hasError) {
          return Text('Error; path: $path, message: ${event.error}');
        }
        // this code is not needed.
        // if (event.hasData == false || event.data!.snapshot.exists == false) {
        //   return builder(null);
        // }
        // value can be null.
        return builder(event.data!.snapshot.value);
      },
    );
  }

  /// 한번만 가져온다. 단, 위젯이 다시 생성되면 다시 가져온다.
  static Widget once({
    required String path,
    required Widget Function(dynamic value) builder,
    Widget? onLoading,
  }) {
    return FutureBuilder(
      future: FirebaseDatabase.instance.ref(path).once(),
      builder: (context, AsyncSnapshot<DatabaseEvent> event) {
        if (event.connectionState == ConnectionState.waiting) {
          return onLoading ?? const SizedBox.shrink();
        }
        if (event.hasError) {
          return Text('Error; ${event.error}');
        }
        if (event.hasData && event.data!.snapshot.exists) {
          return builder(event.data!.snapshot.value);
        } else {
          return builder(null);
        }
      },
    );
  }
}
