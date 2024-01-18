import 'package:firebase_database/firebase_database.dart';

import 'package:fireship/fireship.dart' as fs;
import 'package:fireship/fireship.defines.dart';
import 'package:fireship/src/user/user.service.dart';

class UserModel {
  final String uid;
  String? email;
  String? phoneNumber;
  String? displayName;
  String? photoUrl;
  String? profileBackgroundImageUrl;
  String? stateMessage;
  bool isDisabled;
  int? birthYear;
  int? birthMonth;
  int? birthDay;
  int? createdAt;
  int? order;
  bool isAdmin;
  bool isVerified;
  List<String>? blocks;

  /// Returns true if the user is blocked.
  bool isBlocked(String otherUserUid) =>
      blocks?.contains(otherUserUid) ?? false;

  /// Alias of isBlocked
  bool hasBlocked(String otherUserUid) => isBlocked(otherUserUid);

  bool get notVerified => !isVerified;

  DatabaseReference get ref =>
      FirebaseDatabase.instance.ref('users').child(uid);

  /// See README.md
  DatabaseReference get photoRef =>
      FirebaseDatabase.instance.ref('user-profile-photos').child(uid);

  UserModel({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.profileBackgroundImageUrl,
    this.stateMessage,
    this.isDisabled = false,
    this.birthYear,
    this.birthMonth,
    this.birthDay,
    this.createdAt,
    this.order,
    this.isAdmin = false,
    this.isVerified = false,
    this.blocks,
  });

  factory UserModel.fromSnapshot(DataSnapshot snapshot) {
    final json = snapshot.value as Map<dynamic, dynamic>;
    json['uid'] = snapshot.key;
    return UserModel.fromJson(json);
  }

  /// 사용자 uid 로 부터, UserModel 을 만들어, 빈 UserModel 을 리턴한다.
  ///
  /// 즉, 생성된 UserModel 의 instance 에서, uid 를 제외한 모든 properties 는 null 이지만,
  /// uid 를 기반으로 하는, 각종 method 를 쓸 수 있다.
  ///
  /// 예를 들면, UserModel.fromUid(uid).ref.child('photoUrl').onValue 등과 같이 쓸 수 있으며,
  /// update(), delete() 함수 등을 쓸 수 있다.
  ///
  /// 만약, uid 만으로 사용자 정보 전체를 다 가지고 싶다면,
  factory UserModel.fromUid(String uid) {
    return UserModel.fromJson({
      'uid': uid,
    });
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json, {String? uid}) {
    return UserModel(
      uid: uid ?? json['uid'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      profileBackgroundImageUrl: json['profileBackgroundImageUrl'],
      stateMessage: json['stateMessage'],
      isDisabled: json['isDisabled'] ?? false,
      birthYear: json['birthYear'],
      birthMonth: json['birthMonth'],
      birthDay: json['birthDay'],
      createdAt: json['createdAt'],
      order: json['order'],
      isAdmin: json['isAdmin'] ?? false,
      isVerified: json['isVerified'] ?? false,
      blocks: json[Field.blocks] == null
          ? null
          : List<String>.from(
              (json[Field.blocks] as Map<Object?, Object?>)
                  .entries
                  .map((x) => x.key),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'profileBackgroundImageUrl': profileBackgroundImageUrl,
      'stateMessage': stateMessage,
      'isDisabled': isDisabled,
      'birthYear': birthYear,
      'birthMonth': birthMonth,
      'birthDay': birthDay,
      'createdAt': createdAt,
      'order': order,
      'isAdmin': isAdmin,
      'isVerified': isVerified,
      Field.blocks:
          blocks == null ? null : List<dynamic>.from(blocks!.map((x) => x)),
    };
  }

  @override
  String toString() {
    return 'UserModel(${toJson()})';
  }

  /// Reload user data and apply it to this instance.
  Future<UserModel> reload() async {
    final user = await UserModel.get(uid);

    if (user != null) {
      email = user.email;
      phoneNumber = user.phoneNumber;
      displayName = user.displayName;
      photoUrl = user.photoUrl;
      profileBackgroundImageUrl = user.profileBackgroundImageUrl;
      stateMessage = user.stateMessage;
      isDisabled = user.isDisabled;
      birthYear = user.birthYear;
      birthMonth = user.birthMonth;
      birthDay = user.birthDay;
      createdAt = user.createdAt;
      order = user.order;
      isAdmin = user.isAdmin;
      isVerified = user.isVerified;
    }

    return this;
  }

  /// 사용자 정보 node 전체를 리턴한다.
  static Future<UserModel?> get(String uid) async {
    final nodeData = await fs.get<Map<dynamic, dynamic>>('users/$uid');
    if (nodeData == null) {
      return null;
    }

    nodeData['uid'] = uid;
    return UserModel.fromJson(nodeData);
  }

  /// 사용자의 특정 필만 가져와서 리턴한다.
  ///
  /// ```dart
  /// UserModel.getField(uid, Field.isVerified);
  /// ```
  static Future<T?> getField<T>(String uid, String field) async {
    final nodeData = await fs.get('users/$uid/$field');
    if (nodeData == null) {
      return null;
    }

    return nodeData as T;
  }

  /// Create user document
  ///
  /// This returns UserModel of the created user document.
  static Future<UserModel> create({
    required String uid,
    String? displayName,
    String? photoUrl,
  }) async {
    await fs.set(
      '${Folder.users}/$uid',
      {
        'displayName': displayName,
        'photoUrl': photoUrl,
        'createdAt': ServerValue.timestamp,
        'order': DateTime.now().millisecondsSinceEpoch * -1,
      },
    );

    final created = await UserModel.get(uid);
    UserService.instance.onCreate?.call(created!);
    return created!;
  }

  /// Update user data.
  ///
  /// All user data fields must be updated with this method.
  ///
  /// hasPhotoUrl is automatically set to true if photoUrl is not null.
  Future<UserModel> update({
    String? name,
    String? displayName,
    String? photoUrl,
    String? profileBackgroundImageUrl,
    String? stateMessage,
    int? birthYear,
    int? birthMonth,
    int? birthDay,
    bool? isAdmin,
    bool? isVerified,
    dynamic createdAt,
    dynamic order,
  }) async {
    final data = {
      if (name != null) 'name': name,
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (profileBackgroundImageUrl != null)
        'profileBackgroundImageUrl': profileBackgroundImageUrl,
      if (stateMessage != null) 'stateMessage': stateMessage,
      if (photoUrl != null) 'hasPhotoUrl': true,
      if (birthYear != null) 'birthYear': birthYear,
      if (birthMonth != null) 'birthMonth': birthMonth,
      if (birthDay != null) 'birthDay': birthDay,
      if (isAdmin != null) 'isAdmin': isAdmin,
      if (isVerified != null) 'isVerified': isVerified,
      if (createdAt != null) 'createdAt': createdAt,
      if (order != null) 'order': order,
    };
    if (data.isEmpty) {
      return this;
    }

    // 업데이트부터 하고
    await fs.update(
      'users/$uid',
      data,
    );

    /// 사용자 객체(UserModel) 를 reload 하고, (주의: 로그인한 사용자의 정보가 아닐 수 있다.)
    await reload();
    // final updated = await UserModel.get(uid);

    /// 사진 정보 업데이트
    if (photoUrl != null) {
      await _updateUserProfilePhotos();
    }

    UserService.instance.onUpdate?.call(this);
    return this;
  }

  /// 사진 순서로 목록하기 위한 정보
  ///
  /// createdAt 보다는 updatedAt 을 사용한다.
  Future<void> _updateUserProfilePhotos() async {
    if (photoUrl == null || photoUrl == "") {
      await photoRef.remove();
    } else {
      await photoRef.set({
        Field.photoUrl: photoUrl,
        Field.displayName: displayName,
        Field.updatedAt: DateTime.now().millisecondsSinceEpoch * -1,
      });
    }
  }

  /// Delete user data.
  ///
  /// update() 메소드에 필드를 null 로 주면, 해당 필드가 삭제되지 않고 그냐 그대로 유지된다.
  /// 그래서, delete() 메소드를 따로 만들어서 사용한다.
  Future<void> deletePhotoUrl() async {
    await fs.update(
      'users/$uid',
      {
        Field.photoUrl: null,
        Field.hasPhotoUrl: false,
      },
    );

    await photoRef.remove();
  }

  /// Blocks or unblocks
  ///
  /// After this method call, the user is blocked or unblocked.
  /// Returns true if the user has just blocked blocked, false if unblocked.
  ///
  Future block(String otherUserUid) async {
    if (otherUserUid == uid) {
      throw fs.Issue(fs.Code.blockSelf, 'You cannot block yourself.');
    }
    //
    if (isBlocked(otherUserUid)) {
      await unblockUser(otherUserUid);
      return false;
    } else {
      await blockUser(otherUserUid);
      return true;
    }
  }

  /// Block a user
  Future blockUser(String otherUserUid) async {
    return await ref.child(Field.blocks).child(otherUserUid).set(
          ServerValue.timestamp,
        );
  }

  /// Unblock a user
  ///
  /// Remove the user from the block list by setting null value
  Future unblockUser(String otherUserUid) async {
    return await ref.child(Field.blocks).child(otherUserUid).set(null);
  }
}
