import 'package:fireship/fireship.dart' as fs;

class UserModel {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final bool isDisabled;

  UserModel({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
    required this.photoUrl,
    this.isDisabled = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      isDisabled: json['isDisabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isDisabled': isDisabled,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    bool? isDisabled,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }

  static Future<UserModel?> get(String uid) async {
    final nodeData = await fs.get<Map<String, dynamic>>('users/$uid');
    if (nodeData == null) {
      return null;
    }
    return UserModel.fromJson(nodeData);
  }
}