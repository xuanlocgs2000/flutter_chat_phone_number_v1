import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
import 'package:flutter_chat_ffb/domain/repositories/firebase_repository.dart';

class GetAllUserUseCase {
  final FirebaseRepository repository;

  GetAllUserUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
