import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_ffb/domain/entities/text_message_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class TextMessageModel {
  final String senderName;
  final String senderUID;
  final String recipientName;
  final String recipientUID;
  final String messageType;
  final String message;
  final String messageId;
  final Timestamp time;

  TextMessageModel({
    required this.senderName,
    required this.senderUID,
    required this.recipientName,
    required this.recipientUID,
    required this.messageType,
    required this.message,
    required this.messageId,
    required this.time,
  });

  factory TextMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TextMessageModel(
      senderName: data['senderName'],
      senderUID: data['senderUID'],
      recipientName: data['recipientName'],
      recipientUID: data['recipientUID'],
      messageType: data['messageType'],
      message: data['message'],
      messageId: data['messageId'],
      time: data['time'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "messageType": messageType,
      "message": message,
      "messageId": messageId,
      "time": time,
    };
  }

//   // Convert TextMessageModel to TextMessageEntity (if needed)
//   TextMessageEntity toEntity() {
//     return TextMessageEntity(
//       senderName: senderName,
//       sederUID: senderUID,
//       recipientName: recipientName,
//       recipientUID: recipientUID,
//       messageType: messageType,
//       message: message,
//       messageId: messageId,
//       time: time,
//     );
//   }
}
