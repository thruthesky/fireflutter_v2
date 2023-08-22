import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflutter/src/mixin/firebase_helper.mixin.dart';

class Comment with FirebaseHelper {
  final String id;
  final String postId;
  // TODO reply comment ID
  final String content;
  @override
  final String uid;
  final List<dynamic>? files;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final List<dynamic> likes;
  final bool? deleted;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.uid,
    this.files,
    required this.createdAt,
    required this.updatedAt,
    required this.likes,
    this.deleted,
  });

  factory Comment.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Comment.fromMap(map: documentSnapshot.data() as Map<String, dynamic>, id: documentSnapshot.id);
  }

  factory Comment.fromMap({required Map<String, dynamic> map, required id}) {
    return Comment(
      id: id,
      postId: map['postId'] ?? '',
      content: map['content'] ?? '',
      uid: map['uid'] ?? '',
      files: map['files'],
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      likes: map['likes'] ?? [],
      deleted: map['deleted'],
    );
  }

  @override
  String toString() =>
      'Comment(id: $id, postId: $postId, content: $content, uid: $uid, files: $files, createdAt: $createdAt, updatedAt: $updatedAt, likes: $likes, deleted: $deleted)';
}