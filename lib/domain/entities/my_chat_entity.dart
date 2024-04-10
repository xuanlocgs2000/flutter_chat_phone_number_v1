import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyChatEntity extends Equatable {
  final String senderName;
  final String senderUID;
  final String recipientName;
  final String recipientUID;
  final String channelId;
  final String profileURL;
  final String recipientPhoneNumber;
  final String senderPhoneNumber;
  final String recentTextMessage;
  final bool isRead;
  final bool isArchived;
  final Timestamp time;

  MyChatEntity({
    required this.senderName,
    required this.senderUID,
    required this.recipientName,
    required this.recipientUID,
    required this.channelId,
    required this.profileURL,
    required this.recipientPhoneNumber,
    required this.senderPhoneNumber,
    required this.recentTextMessage,
    required this.isRead,
    required this.isArchived,
    required this.time,
  });

  @override
  List<Object?> get props => [
        senderName,
        senderUID,
        recipientName,
        recipientUID,
        channelId,
        profileURL,
        recipientPhoneNumber,
        senderPhoneNumber,
        recentTextMessage,
        isRead,
        isArchived,
        time,
      ];

  MyChatEntity copyWith({
    String? senderName,
    String? senderUID,
    String? recipientName,
    String? recipientUID,
    String? channelId,
    String? profileURL,
    String? recipientPhoneNumber,
    String? senderPhoneNumber,
    String? recentTextMessage,
    bool? isRead,
    bool? isArchived,
    Timestamp? time,
  }) {
    return MyChatEntity(
      senderName: senderName ?? this.senderName,
      senderUID: senderUID ?? this.senderUID,
      recipientName: recipientName ?? this.recipientName,
      recipientUID: recipientUID ?? this.recipientUID,
      channelId: channelId ?? this.channelId,
      profileURL: profileURL ?? this.profileURL,
      recipientPhoneNumber: recipientPhoneNumber ?? this.recipientPhoneNumber,
      senderPhoneNumber: senderPhoneNumber ?? this.senderPhoneNumber,
      recentTextMessage: recentTextMessage ?? this.recentTextMessage,
      isRead: isRead ?? this.isRead,
      isArchived: isArchived ?? this.isArchived,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderUID': senderUID,
      'recipientName': recipientName,
      'recipientUID': recipientUID,
      'channelId': channelId,
      'profileURL': profileURL,
      'recipientPhoneNumber': recipientPhoneNumber,
      'senderPhoneNumber': senderPhoneNumber,
      'recentTextMessage': recentTextMessage,
      'isRead': isRead,
      'isArchived': isArchived,
      'time': time,
    };
  }

  factory MyChatEntity.fromMap(Map<String, dynamic> map) {
    return MyChatEntity(
      senderName: map['senderName'],
      senderUID: map['senderUID'],
      recipientName: map['recipientName'],
      recipientUID: map['recipientUID'],
      channelId: map['channelId'],
      profileURL: map['profileURL'],
      recipientPhoneNumber: map['recipientPhoneNumber'],
      senderPhoneNumber: map['senderPhoneNumber'],
      recentTextMessage: map['recentTextMessage'],
      isRead: map['isRead'],
      isArchived: map['isArchived'],
      time: map['time'],
    );
  }
}
