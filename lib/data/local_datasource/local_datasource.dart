import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_chat_ffb/domain/entities/contact_entity.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocalDataSource {
  Future<List<ContactEntity>> getDeviceNumbers();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<ContactEntity>> getDeviceNumbers() async {
    // Kiểm tra và yêu cầu quyền truy cập danh bạ
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();
    if (permissionStatus != PermissionStatus.granted) {
      throw Exception('Permission denied');
    }

    List<ContactEntity> contacts = [];
    // Lấy danh sách liên lạc từ thiết bị
    final Iterable<Contact> deviceContacts =
        await FlutterContacts.getContacts();

    // Duyệt qua danh sách liên lạc và tạo các đối tượng ContactEntity
    for (var contact in deviceContacts) {
      for (var phone in contact.phones) {
        contacts.add(ContactEntity(
          phoneNumber: phone.number,
          label: contact.displayName,
        ));
      }
    }

    return contacts;
  }
}
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter_chat_ffb/domain/entities/contact_entity.dart';

// abstract class LocalDataSource {
//   Future<List<ContactEntity>> getDeviceNumbers();
// }

// class LocalDataSourceImpl implements LocalDataSource {
//   @override
//   Future<List<ContactEntity>> getDeviceNumbers() async {
//     List<ContactEntity> contacts = [];
//     final getContactsData = await ContactsService.getContacts();

//     for (var myContact in getContactsData) {
//       myContact.phones?.forEach((phoneData) {
//         contacts.add(ContactEntity(
//           phoneNumber: phoneData.value!,
//           label: myContact.displayName!,
//         ));
//       });
//     }
//     return contacts;
//   }
// }
