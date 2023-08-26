import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflutter/fireflutter.dart';

class Message with FirebaseHelper {
  final String id;
  final String? text;
  @override
  final String uid;
  final Timestamp createdAt;
  final String? url;

  Message({
    required this.id,
    required this.text,
    required this.url,
    required this.uid,
    required this.createdAt,
  });

  factory Message.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Message.fromMap(map: documentSnapshot.data() as Map<String, dynamic>, id: documentSnapshot.id);
  }

  factory Message.fromMap({required Map<String, dynamic> map, required id}) {
    return Message(
      id: id,
      text: map['text'],
      url: map['url'],
      uid: map['uid'] ?? '',
      createdAt: (map['createdAt'] == null || map['createdAt'] is FieldValue) ? Timestamp.now() : map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'url': url,
      'uid': uid,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() => 'Message(id: $id, text: $text,  url: $url, uid: $uid, createdAt: $createdAt)';
}
