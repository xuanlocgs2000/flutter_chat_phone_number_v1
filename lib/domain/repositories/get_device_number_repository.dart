import 'package:flutter_chat_ffb/domain/entities/contact_entity.dart';

abstract class GetDeviceNumberRepository {
  Future<List<ContactEntity>> getDeviceNumbers();
}
