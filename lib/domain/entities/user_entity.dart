import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? name;
  String? email;
  String? phoneNumber;
  bool? isOnline;
  String? uid;
  String? status;
  String? profileUrl;
  UserEntity(
      {this.name,
      this.email,
      this.phoneNumber,
      this.isOnline,
      this.uid,
      this.status,
      this.profileUrl});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [name, email, phoneNumber, isOnline, uid, status, profileUrl];
}
