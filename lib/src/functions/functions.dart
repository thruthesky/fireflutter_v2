import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:timeago/timeago.dart' as timeago;

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

void dog(String msg) {
  if (kReleaseMode) return;
  developer.log('--> $msg', time: DateTime.now(), name: '🐶', level: 2000);
}

/// Shows a [SnackBar] at the bottom of the screen.
Future<void> showSnackBar(BuildContext? context, String message) async {
  context ??= FireFlutterService.instance.context;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}

Future<ImageSource?> chooseUploadSource(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Text(tr.chooseUploadFrom),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Photo Gallery'),
              onTap: () async {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    },
  );
  return source;
}

/// Replaces characters in [input] that are illegal/unsafe for filenames.
///
/// You can also use a custom [replacement] if needed.
///
/// Illegal Characters on Various Operating Systems:
/// / ? < > \ : * | "
/// https://kb.acronis.com/content/39790
///
/// Unicode Control codes:
/// C0 0x00-0x1f & C1 (0x80-0x9f)
/// https://en.wikipedia.org/wiki/C0_and_C1_control_codes
///
/// Reserved filenames on Unix-based systems (".", "..")
/// Reserved filenames in Windows ("CON", "PRN", "AUX", "NUL", "COM1",
/// "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9",
/// "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", and
/// "LPT9") case-insesitively and with or without filename extensions.
///
/// Each results have a maximum length of 255 characters:
/// https://unix.stackexchange.com/questions/32795/what-is-the-maximum-allowed-filename-and-folder-size-with-ecryptfs
///
/// Example:
/// ```dart
/// import 'package:sanitize_filename/sanitize_filename.dart';
///
/// const unsafeUserInput = "~/.\u0000ssh/authorized_keys";
///
/// // "~.sshauthorized_keys"
/// sanitizeFilename(unsafeUserInput);
///
/// // "~-.-ssh-authorized_keys"
/// sanitizeFilename(unsafeUserInput, replacement: "-");
/// ```
String sanitizeFilename(String input, {String replacement = ''}) {
  final result = input
      // illegalRe
      .replaceAll(
        RegExp(r'[\/\?<>\\:\*\|"]'),
        replacement,
      )
      // controlRe
      .replaceAll(
        RegExp(
          r'[\x00-\x1f\x80-\x9f]',
        ),
        replacement,
      )
      // reservedRe
      .replaceFirst(
        RegExp(r'^\.+$'),
        replacement,
      )
      // windowsReservedRe
      .replaceFirst(
        RegExp(
          r'^(con|prn|aux|nul|com[0-9]|lpt[0-9])(\..*)?$',
          caseSensitive: false,
        ),
        replacement,
      )
      // windowsTrailingRe
      .replaceFirst(RegExp(r'[\. ]+$'), replacement);

  return result.length > 255 ? result.substring(0, 255) : result;
}

/// Alias of [ChatService.instance.getOtherUserUid]
///
/// Returns the other user's uid from a list of users.
String otherUserUid(List<String> users) {
  return ChatService.instance.getOtherUserUid(users);
}

/// Returns the indent value for the given [no].
///
/// Use this to display the indent for comment reply.
/// The indent(depth) start with 1.
double indent(int? no) {
  if (no == null) return 0;
  if (no == 0 || no == 1) {
    return 0;
  } else if (no == 2) {
    return 32;
  } else if (no == 3) {
    return 64;
  } else if (no == 4) {
    return 80;
  } else if (no == 5) {
    return 96;
  } else if (no == 6) {
    return 106;
  } else {
    return 112;
  }
}

/// It returns one of 'web', 'android', 'fuchsia', 'ios', 'linux', 'macos', 'windows'.
String platformName() {
  if (kIsWeb) {
    return 'web';
  } else {
    return defaultTargetPlatform.name.toLowerCase();
  }
}

void warningSnackbar(BuildContext? context, String message) async {
  context ??= FireFlutterService.instance.context;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Theme.of(context).colorScheme.error,
    ),
  );
}

/// Display a snackbar
///
/// When the body of the snackbar is tapped, [onTap] will be called with a callback that will hide the snackbar.
///
/// Call the function parameter passed on the callback to close the snackbar.
/// ```dart
/// toast( title: 'title',  message: 'message', onTap: (close) => close());
/// toast(  title: 'error title', message: 'error message',  error: true );
/// ```
ScaffoldFeatureController toast({
  required String title,
  required String message,
  Icon? icon,
  Duration duration = const Duration(seconds: 8),
  Function(Function)? onTap,
  bool? error,
  bool hideCloseButton = false,
  Color? backgroundColor,
  Color? foregroundColor,
  double runSpacing = 12,
}) {
  final context = FireFlutterService.instance.context;
  if (error == true) {
    backgroundColor ??= Theme.of(context).colorScheme.error;
    foregroundColor ??= Theme.of(context).colorScheme.onError;
  }
  {
    backgroundColor ??= Theme.of(context).colorScheme.primary;
    foregroundColor ??= Theme.of(context).colorScheme.onPrimary;
  }

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration,
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (onTap == null) return;

                onTap(() {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                });
              },
              child: Row(children: [
                if (icon != null) ...[
                  Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: IconThemeData(color: foregroundColor),
                    ),
                    child: icon,
                  ),
                  SizedBox(width: runSpacing),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title),
                      Text(message),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          if (hideCloseButton == false)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(tr.dismiss, style: TextStyle(color: foregroundColor)),
            )
        ],
      ),
    ),
  );
}

ScaffoldFeatureController loginFirstToast({
  Icon? icon,
  Duration duration = const Duration(seconds: 8),
  Function(Function)? onTap,
}) {
  return toast(
    title: tr.loginFirstTitle,
    message: tr.loginFirstMessage,
    icon: icon,
    duration: duration,
    onTap: onTap,
  );
}

/// Alias of [prompt]
Future<String?> input({
  required BuildContext context,
  required String title,
  String? subtitle,
  required String hintText,
  String? initialValue,
}) {
  return prompt(
    context: context,
    title: title,
    subtitle: subtitle,
    hintText: hintText,
    initialValue: initialValue,
  );
}

/// randomString that returns a random string of length [length].
String randomString([length = 12]) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rnd = Random(DateTime.now().millisecondsSinceEpoch);
  final buf = StringBuffer();
  for (var x = 0; x < length; x++) {
    buf.write(chars[rnd.nextInt(chars.length)]);
  }
  return buf.toString();
}

/// Return a string of date/time agao
String dateTimeAgo(DateTime dateTime, {String? locale}) {
  return timeago.format(dateTime, locale: locale);
}

/// Returns a string of "yyyy-MM-dd" or "HH:mm:ss"
String dateTimeShort(DateTime dt) {
  final now = DateTime.now();
  if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
    return DateFormat.jm().format(dt);
  } else {
    return DateFormat('yy.MM.dd').format(dt);
  }
}

/// Returns now, 1s, 2m, 3h, 4d, 5Mo, 6y
String dateTimeAbbreviated(DateTime dt) {
  final now = DateTime.now();

  final dateDifference = now.difference(dt);

  if (dateDifference.inSeconds < 20) {
    return 'now';
  } else if (dateDifference.inSeconds < 60) {
    return '${dateDifference.inSeconds}s';
  } else if (dateDifference.inMinutes < 60) {
    return '${dateDifference.inMinutes}m';
  } else if (dateDifference.inHours < 24) {
    return '${dateDifference.inHours}h';
  } else if (dateDifference.inDays < 30) {
    return '${dateDifference.inDays}d';
  } else if (dateDifference.inDays < 365) {
    return '${dateDifference.inDays ~/ 30}Mo';
  } else {
    return '${dateDifference.inDays ~/ 365}y';
  }
}

/// [YoutubeThumbnailQuality], [getYoutubeThumbnail], [getYoutubeIdFromUrl]
/// are coming from [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter).
///
///
/// Converts fully qualified YouTube Url to video id.
///
/// If videoId is passed as url then no conversion is done.
///
String? getYoutubeIdFromUrl(String url, {bool trimWhitespaces = true}) {
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/(?:music\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/shorts\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}

/// Quality of YouTube video thumbnail.
class YoutubeThumbnailQuality {
  /// 120*90
  static const String defaultQuality = 'default';

  /// 320*180
  static const String medium = 'mqdefault';

  /// 480*360
  static const String high = 'hqdefault';

  /// 640*480
  static const String standard = 'sddefault';

  /// Unscaled thumbnail
  static const String max = 'maxresdefault';
}

/// Grabs YouTube video's thumbnail for provided video id.
String getYoutubeThumbnail({
  required String videoId,
  String quality = YoutubeThumbnailQuality.standard,
  bool webp = true,
}) =>
    webp ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp' : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

/// It opens the SMS app with the number and message.
///
/// Use this to open SMS with default number and text message.
///
Future<bool> launchSMS({required String phoneNumber, required String msg}) async {
  // Android 'sms:+39 348 060 888?body=hello%20there';
  String body = Uri.encodeComponent(msg);

  String androidPh = phoneNumber.replaceAll("(", "").replaceAll(")", "");
  String androidUri = 'sms:$androidPh?body=$body';

  String iosPh = phoneNumber
      .replaceAll("+", "00")
      .replaceAll("(", "")
      .replaceAll(")", ""); //'sms:0039-222-060-888?body=hello%20there';
  String iosUri = 'sms:$iosPh&body=$body';

  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(iosUri))) {
      return await launchUrl(Uri.parse(iosUri));
    } else {
      return false;
    }
  } else if (Platform.isAndroid) {
    if (await canLaunchUrl(Uri.parse(androidUri))) {
      return await launchUrl(Uri.parse(androidUri));
    } else {
      return false;
    }
  } else {
    return false;
  }
}
