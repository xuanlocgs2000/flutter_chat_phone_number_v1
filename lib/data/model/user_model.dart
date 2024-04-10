import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  String? name;
  String? email;
  String? phoneNumber;
  bool? isOnline;
  String? uid;
  String? status;
  String? profileUrl;
  UserModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.isOnline,
    this.uid,
    this.status,
    this.profileUrl,
  }) : super(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          isOnline: isOnline,
          uid: uid,
          status: status,
          profileUrl: profileUrl,
        );

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!; // Use non-null assertion after type check
    return UserModel(
      name: data['name'] as String,
      email: data['email'] as String,
      phoneNumber: data['phoneNumber'] as String,
      uid: data['uid'] as String,
      isOnline: data['isOnline'] as bool,
      profileUrl: data['profileUrl'] as String,
      status: data['status'] as String,
    );
  }

  Map<String, dynamic> toDocument() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "uid": uid,
        "isOnline": isOnline,
        "profileUrl": profileUrl,
        "status": status,
      };
}
