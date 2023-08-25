import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:fireflutter/src/functions/comment_sort_string.dart';
import 'package:fireflutter/src/mixin/firebase_helper.mixin.dart';
import 'package:fireflutter/src/service/comment.service.dart';

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

  /// Parent ID is the comment ID of the comment that this comment is replying to.
  /// It will be null if this comment is not a reply (or the first level of comment)
  final String? parentId;
  final String sort;
  final int depth;

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
    this.parentId,
    required this.sort,
    required this.depth,
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
      createdAt: (map['createdAt'] is Timestamp) ? map['createdAt'] : Timestamp.now(),
      updatedAt: (map['updatedAt'] is Timestamp) ? map['updatedAt'] : Timestamp.now(),
      likes: map['likes'] ?? [],
      deleted: map['deleted'],
      parentId: map['parentId'],
      sort: map['sort'],
      depth: map['depth'] ?? 0,
    );
  }

  static Future<Comment> create({
    required Post post,
    Comment? parent,
    required String content,
    List<String>? files,
  }) async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    final Map<String, dynamic> commentData = {
      'content': content,
      'postId': post.id,
      if (files != null) 'files': files,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'uid': myUid,
      if (parent != null) 'parentId': parent.id,
      'sort':
          getCommentSortString(noOfComments: post.noOfComments, depth: parent?.depth ?? 0, sortString: parent?.sort),
      'depth': parent == null ? 1 : parent.depth + 1,
    };
    await CommentService.instance.commentCol.add(commentData);
    await PostService.instance.postCol.doc(post.id).update({
      'noOfComments': FieldValue.increment(1),
    });
    return Comment.fromMap(map: commentData, id: post.id);
  }

  @override
  String toString() =>
      'Comment(id: $id, postId: $postId, content: $content, uid: $uid, files: $files, createdAt: $createdAt, updatedAt: $updatedAt, likes: $likes, deleted: $deleted, parentId: $parentId, sort: $sort, depth: $depth)';
}
