import 'package:flutter_chat_ffb/domain/repositories/firebase_repository.dart';

class CreateOneToOneChatChannelUseCase {
  final FirebaseRepository repository;

  CreateOneToOneChatChannelUseCase({required this.repository});

  Future<void> call(String uid, String otherUid) async {
    return repository.createOneToOneChatChannel(uid, otherUid);
  }
}
