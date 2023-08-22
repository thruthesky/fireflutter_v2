import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';

class Post with FirebaseHelper {
  final String id;
  final String categoryId;
  final String title;
  final String content;
  @override
  final String uid;
  final List<dynamic>? files;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final List<dynamic> likes;
  final bool? deleted;

  Post({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.uid,
    this.files,
    required this.createdAt,
    required this.updatedAt,
    required this.likes,
    this.deleted,
  });

  factory Post.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Post.fromMap(map: documentSnapshot.data() as Map<String, dynamic>, id: documentSnapshot.id);
  }

  factory Post.fromMap({required Map<String, dynamic> map, required id}) {
    return Post(
      id: id,
      categoryId: map['categoryId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      uid: map['uid'] ?? '',
      files: map['files'],
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      likes: map['likes'] ?? [],
      deleted: map['deleted'],
    );
  }

  static Future<Post> create({
    required String categoryId,
    required String title,
    required String content,
    List<String>? files,
  }) async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    final Map<String, dynamic> postData = {
      'title': title,
      'content': content,
      'categoryId': categoryId,
      if (files != null) 'files': files,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'uid': myUid,
    };
    final postId = PostService.instance.postCol.doc().id;
    await PostService.instance.postCol.doc(postId).set(postData);
    postData['createdAt'] = Timestamp.now();
    postData['updatedAt'] = Timestamp.now();
    return Post.fromMap(map: postData, id: postId);
  }
}