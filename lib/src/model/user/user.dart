import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User with FirebaseHelper {
  static const String collectionName = 'users';

  /// '/users' collection
  static CollectionReference col = FirebaseFirestore.instance.collection(collectionName);

  /// '/users/{uid}' document.
  ///
  /// Example
  /// ```dart
  /// User.doc('xxx').update({...});
  /// ```
  static DocumentReference doc(String uid) => col.doc(uid);

  /// This holds the original JSON document data of the user document. This is
  /// useful when you want to save custom data in the user document.
  late Map<String, dynamic> data;

  @override
  final String uid;

  /// [isAdmin] is set to true if the logged in user is an admin.
  bool isAdmin = false;

  /// 만약, dsiplayName 이 없으면, uid 의 앞 두글자를 대문자로 표시.
  final String displayName;
  final String name;
  final String firstName;
  final String lastName;
  final String middleName;
  final String photoUrl;

  /// ID 카드(신분증)으로 인증된 사용자의 경우, 인증 코드.
  /// 신분증 등록 후, 텍스트 추출 -> 이름 대조 또는 기타 방법으로 인증된 사용자의 경우 true
  ///
  /// 이 값은 다양하게 응용해서 활용하면 된다. 예) 신분증 업로드 후, 신분증 경로 URL 을 저장하거나, 파일 이름 또는 기타 코드를 입력하면 된다.
  final String idVerifiedCode;
  final bool isVerified;

  ///
  final String phoneNumber;
  final String email;

  /// User state. It's like user's status or mood, motto. You can save whatever here.
  /// 상태. 개인의 상태, 무드, 인사말 등. 예를 들어, 휴가중. 또는 모토. 인생은 모험이 아니면 아무것도 아닙니다.
  final String state;

  /// User state image (or public profile title image).
  ///
  /// Use this for any purpose to display user's current state. Good example of
  /// using this is to display user's public profile title image.
  final String stateImageUrl;

  final int birthYear;
  final int birthMonth;
  final int birthDay;

  final int noOfPosts;
  final int noOfComments;

  /// [type] is a string value that can be used to categorize the user. You can
  /// think of it as a member type. For example, you can set it to 'player' or
  /// 'coach' or 'admin' or 'manager' or 'staff' or 'parent' or 'fan' or
  /// 'student', 'guest', etc...
  final String type;

  /// Indicates whether the user has a photoUrl.
  ///
  /// Note this value is automatically set to true when the user uploads a photo by the easy-extension
  /// So, don't set this value manually.
  /// And this is available only on `/search-user-data` in Firestore or `/users` in Realtime Database.
  /// It does not exists in `/users` in Firestore.
  ///
  final bool hasPhotoUrl;

  /// 사용자 문서가 생성된 시간. 항상 존재 해야 함. Firestore 서버 시간
  @FirebaseDateTimeConverter()
  @JsonKey(includeFromJson: false, includeToJson: true)
  final DateTime createdAt;

  /// Set this to true when the user has completed the profile.
  /// This should be set when the user submit the profile form.
  ///
  /// 사용자가 회원 정보를 업데이트 할 때, 이 값을 true 또는 false 로 지정한다.
  /// 이 값이 false 이면, 앱에서 회원 정보를 입력하라는 메시지를 표시하거나 기타 동작을 하게 할 수 있다.
  final bool isComplete;

  final List<String> followers;
  final List<String> followings;

  /// 사용자 문서가 존재하지 않는 경우, 이 값이 false 이다.
  /// 특히, 이 값이 false 이면 사용자 로그인을 했는데, 사용자 문서가 존재하지 않는 경우이다.
  final bool exists;

  bool cached;

  /// Likes
  final List<String> likes;

  User({
    required this.uid,
    this.isAdmin = false,
    this.displayName = '',
    this.name = '',
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
    this.photoUrl = '',
    this.hasPhotoUrl = false,
    this.idVerifiedCode = '',
    this.isVerified = false,
    this.phoneNumber = '',
    this.email = '',
    this.state = '',
    this.stateImageUrl = '',
    this.birthYear = 0,
    this.birthMonth = 0,
    this.birthDay = 0,
    this.type = '',
    dynamic createdAt,
    this.isComplete = false,
    this.exists = true,
    this.noOfPosts = 0,
    this.noOfComments = 0,
    this.followers = const [],
    this.followings = const [],
    this.data = const {},
    this.cached = false,
    this.likes = const [],
  }) : createdAt = (createdAt is Timestamp) ? createdAt.toDate() : DateTime.now();

  factory User.notExists() {
    return User(uid: '', exists: false);
  }

  /// Returns a user with uid. All other properties are empty.
  ///
  ///
  factory User.fromUid(String uid) {
    return User(uid: uid);
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return User.fromJson(
      json: documentSnapshot.data() as Map<String, dynamic>,
      id: documentSnapshot.id,
    );
  }

  @Deprecated('Use fromJson instead')
  factory User.fromMap({required Map<String, dynamic> map, required String id}) {
    map['uid'] = id;
    return _$UserFromJson(map);
  }
  factory User.fromJson({required Map<String, dynamic> json, required String id}) {
    json['uid'] = id;
    return _$UserFromJson(json)..data = json;
  }

  Map<String, dynamic> toMap() {
    return _$UserToJson(this);
  }

  @override
  String toString() => '''User(${toMap().toString().replaceAll('\n', '')}})''';

  /// Get user document
  ///
  /// If the user document does not exist, it will return null. It does not throw an exception.
  ///
  /// [uid] is the user's uid. If it's null, it will get the login user's document.
  ///
  /// Note, that It gets data from /users collections. It does not get data from /search-user-data collection.
  static Future<User?> get([String? uid]) async {
    uid ??= UserService.instance.uid;
    final snapshot = await FirebaseFirestore.instance.collection(collectionName).doc(uid).get();
    if (snapshot.exists == false) {
      return null;
    }
    return User.fromDocumentSnapshot(snapshot);
  }

  /// 사용자 문서를 Realtime Database 에 Sync 된 문서를 읽어 온다.
  static Future<User?> getFromDatabaseSync(String uid) async {
    final snapshot = await FirebaseDatabase.instance.ref().child(collectionName).child(uid).get();
    if (!snapshot.exists) {
      return null;
    }
    return User.fromJson(json: Map<String, dynamic>.from(snapshot.value as Map), id: uid);
  }

  /// 사용자 문서를 생성한다.
  ///
  /// 사용자 문서가 이미 존재하는 경우, 문서를 덮어쓴다.
  ///
  /// FirebaseAuth 에 먼저 로그인을 한 후, 함수를 호출해야 Security rules 를 통과 할 수 있다.
  ///
  /// 참고: README.md
  ///
  /// Example;
  /// ```dart
  /// User.create(uid: 'xxx');
  /// ```
  static Future<User> create({required String uid}) async {
    await FirebaseFirestore.instance.collection(User.collectionName).doc(uid).set({
      'uid': uid,
      'email': '',
      'displayName': '',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return (await get(uid))!;
  }

  static Future<void> create2(User user) async {
    final data = user.toMap();
    data.remove('isAdmin');
    data.remove('disabled');
    data.remove('isVerified');
    data.remove('data');
    data.remove('exists');
    data.remove('cached');
    data['createdAt'] = FieldValue.serverTimestamp();
    // print(data);

    // print(User.doc(user.uid).path);
    return await User.doc(user.uid).set(data);
  }

  /// Update user document
  ///
  /// Update the user document under /users/{uid} NOT only for the login user
  /// but also other user document as long as the permission allows.
  ///
  /// To update other user's data, you may use "User.fromUid().update(...)".
  ///
  /// Note that, it only updates. It does not return the updated user document,
  /// Nor it update the object itself.
  ///
  /// It sets with merge true option just incase if the user document may not
  /// exists.
  ///
  /// Example
  /// ```dart
  /// my.update( noOfPosts: FieldValue.increment(1) ); // when UserService.instance.init() is called
  /// User.fromUid(FirebaseAuth.instance.currentUser!.uid).update( noOfPosts: FieldValue.increment(1) ); // when UserService.instance.init() is not called
  /// ```
  Future<void> update({
    String? name,
    String? firstName,
    String? lastName,
    String? middleName,
    String? displayName,
    String? photoUrl,
    bool? hasPhotoUrl,
    String? idVerifiedCode,
    // bool? isVerified,
    String? phoneNumber,
    String? email,
    String? state,
    String? stateImageUrl,
    int? birthYear,
    int? birthMonth,
    int? birthDay,
    FieldValue? noOfPosts,
    FieldValue? noOfComments,
    String? type,
    bool? isComplete,
    FieldValue? followings,
    FieldValue? followers,
    FieldValue? likes,
    String? field,
    dynamic value,
    Map<String, dynamic> data = const {},
  }) async {
    final docData = {
      ...{
        if (name != null) 'name': name,
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (middleName != null) 'middleName': middleName,
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'photoUrl': photoUrl,
        if (hasPhotoUrl != null) 'hasPhotoUrl': hasPhotoUrl,
        if (idVerifiedCode != null) 'idVerifiedCode': idVerifiedCode,
        // if (isVerified != null) 'isVerified': isVerified,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (email != null) 'email': email,
        if (state != null) 'state': state,
        if (stateImageUrl != null) 'stateImageUrl': stateImageUrl,
        if (birthYear != null) 'birthYear': birthYear,
        if (birthMonth != null) 'birthMonth': birthMonth,
        if (birthDay != null) 'birthDay': birthDay,
        if (noOfPosts != null) 'noOfPosts': noOfPosts,
        if (noOfComments != null) 'noOfComments': noOfComments,
        if (type != null) 'type': type,
        if (isComplete != null) 'isComplete': isComplete,
        if (followings != null) 'followings': followings,
        if (followers != null) 'followers': followers,
        if (likes != null) 'likes': likes,
        if (field != null && value != null) field: value,
      },
      ...data
    };

    return await userDoc(uid).set(
      docData,
      SetOptions(merge: true),
    );
  }

  /// If the user has completed the profile, set the isComplete field to true.
  Future<void> updateComplete(bool isComplete) async {
    return await update(isComplete: isComplete);
  }

  /// Follow
  ///
  /// See README for details
  ///
  /// Returns true if followed a user. Returns false if unfollowed a user.
  ///
  Future<bool> follow(String otherUid) async {
    final myUid = UserService.instance.uid;
    if (followings.contains(otherUid)) {
      await update(
        followings: FieldValue.arrayRemove([otherUid]),
      );
      await userDoc(otherUid).set({
        'followers': FieldValue.arrayRemove([myUid])
      }, SetOptions(merge: true));

      return false;
    } else {
      await update(
        followings: FieldValue.arrayUnion([otherUid]),
      );
      await userDoc(otherUid).set({
        'followers': FieldValue.arrayUnion([myUid])
      }, SetOptions(merge: true));
      return true;
    }
  }

  /// Likes
  ///
  /// I am the one who likes other users.
  /// ! But the user model instance must be the other user's model instance.
  ///
  ///
  /// See README for details
  ///
  /// Returns true if liked a user. Returns false if unliked a user.
  Future<bool> like() async {
    if (likes.contains(my.uid)) {
      /// Since sync is slow, update the sync field first.
      /// Move this code somewhere else.
      final newLikes = likes..remove(my.uid);
      rtdb.ref('users/$uid').update(
        {
          'likes': newLikes,
        },
      );
      await update(likes: FieldValue.arrayRemove([my.uid]));

      return false;
    } else {
      /// Since sync is slow, update the sync field first.
      /// Move this code somewhere else.
      rtdb.ref('users/$uid').update(
        {
          'likes': [...likes, my.uid],
        },
      );
      await update(likes: FieldValue.arrayUnion([my.uid]));
      return true;
    }
  }

  String get noOfLikes => likes.isEmpty ? "Like" : "${likes.length} Likes";
}