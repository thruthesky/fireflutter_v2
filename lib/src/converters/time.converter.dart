import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Convert DateTime from RTDB timestamp or from Firestore timestamp
///
class FirebaseDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const FirebaseDateTimeConverter();

  @override
  DateTime fromJson(dynamic data) {
    // The createdAt may be int (from RTDB) or Timestamp (from Fireestore), or null.
    if (data is int) {
      return DateTime.fromMillisecondsSinceEpoch((data).abs());
    } else if (data is Timestamp) {
      // Firestore timestamp
      return data.toDate();
    } else if (data is DateTime) {
      return data;
    } else if (data == null) {
      return DateTime(1970); // The beginning of epoch.
    } else if (data is FieldValue) {
      // Firestore pending writes,
      return DateTime.now();
    } else {
      // Or whatever, just return current time.
      return DateTime.now();
    }
  }

  /// ! Warning, this will return an integer of the milliseconds since epoch.
  /// So, you cannot directly save it as a timestamp in Firestore or RTDB.
  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
