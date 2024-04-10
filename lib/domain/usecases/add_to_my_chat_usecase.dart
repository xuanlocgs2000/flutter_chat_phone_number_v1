

import 'package:flutter_chat_ffb/domain/entities/my_chat_entity.dart';
import 'package:flutter_chat_ffb/domain/repositories/firebase_repository.dart';

class AddToMyChatUseCase{
  final FirebaseRepository repository;

  AddToMyChatUseCase({required this.repository});

  Future<void> call(MyChatEntity myChatEntity)async{
    return await repository.addToMyChat(myChatEntity);
  }
}