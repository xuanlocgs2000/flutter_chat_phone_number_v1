import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  final String senderName;
  final String senderUID;
  final String recipientName;
  final String recipientUID;
  final String messageType;
  final String message;
  final String messageId;
  final Timestamp time;

  TextMessageEntity({
    required this.senderName,
    required this.senderUID,
    required this.recipientName,
    required this.recipientUID,
    required this.messageType,
    required this.message,
    required this.messageId,
    required this.time,
  });

  @override
  List<Object?> get props => [
        senderName,
        senderUID,
        recipientName,
        recipientUID,
        messageType,
        message,
        messageId,
        time,
      ];

  TextMessageEntity copyWith({
    String? senderName,
    String? senderUID,
    String? recipientName,
    String? recipientUID,
    String? messageType,
    String? message,
    String? messageId,
    Timestamp? time,
  }) {
    return TextMessageEntity(
      senderName: senderName ?? this.senderName,
      senderUID: senderUID ?? this.senderUID,
      recipientName: recipientName ?? this.recipientName,
      recipientUID: recipientUID ?? this.recipientUID,
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      messageId: messageId ?? this.messageId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderUID': senderUID,
      'recipientName': recipientName,
      'recipientUID': recipientUID,
      'messageType': messageType,
      'message': message,
      'messageId': messageId,
      'time': time,
    };
  }

  factory TextMessageEntity.fromMap(Map<String, dynamic> map) {
    return TextMessageEntity(
      senderName: map['senderName'],
      senderUID: map['senderUID'],
      recipientName: map['recipientName'],
      recipientUID: map['recipientUID'],
      messageType: map['messageType'],
      message: map['message'],
      messageId: map['messageId'],
      time: map['time'],
    );
  }
}
