import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
import 'package:flutter_chat_ffb/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return await repository.getCreateCurrentUser(user);
  }
}
