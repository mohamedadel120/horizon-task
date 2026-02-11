import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/base/base_model.dart';

class AppUserModel extends BaseModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AppUserModel({this.uid, this.email, this.displayName, this.photoURL});

  factory AppUserModel.fromFirebaseUser(User user) {
    return AppUserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  @override
  AppUserModel fromMap(Map<String, dynamic> json) {
    return AppUserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  @override
  AppUserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
  }) {
    return AppUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  AppUserModel fakeData() {
    return AppUserModel(
      uid: '123456',
      email: 'user@example.com',
      displayName: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );
  }
}
