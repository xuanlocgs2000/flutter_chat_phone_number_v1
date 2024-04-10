import 'package:cloud_firestore/cloud_firestore.dart';

class MyChatModel {
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

  MyChatModel({
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

  factory MyChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return MyChatModel(
      senderName: data['senderName'] ?? '',
      senderUID: data['senderUID'] ?? '',
      senderPhoneNumber: data['senderPhoneNumber'] ?? '',
      recipientName: data['recipientName'] ?? '',
      recipientUID: data['recipientUID'] ?? '',
      recipientPhoneNumber: data['recipientPhoneNumber'] ?? '',
      channelId: data['channelId'] ?? '',
      profileURL: data['profileURL'] ?? '',
      recentTextMessage: data['recentTextMessage'] ?? '',
      isRead: data['isRead'] ?? false,
      isArchived: data['isArchived'] ?? false,
      time: data['time'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "channelId": channelId,
      "profileURL": profileURL,
      "recipientPhoneNumber": recipientPhoneNumber,
      "senderPhoneNumber": senderPhoneNumber,
      "recentTextMessage": recentTextMessage,
      "isRead": isRead,
      "isArchived": isArchived,
      "time": time,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "channelId": channelId,
      "profileURL": profileURL,
      "recipientPhoneNumber": recipientPhoneNumber,
      "senderPhoneNumber": senderPhoneNumber,
      "recentTextMessage": recentTextMessage,
      "isRead": isRead,
      "isArchived": isArchived,
      "time": time,
    };
  }

  factory MyChatModel.fromJson(Map<String, dynamic> json) {
    return MyChatModel(
      senderName: json['senderName'] ?? '',
      senderUID: json['senderUID'] ?? '',
      recipientName: json['recipientName'] ?? '',
      recipientUID: json['recipientUID'] ?? '',
      channelId: json['channelId'] ?? '',
      profileURL: json['profileURL'] ?? '',
      recipientPhoneNumber: json['recipientPhoneNumber'] ?? '',
      senderPhoneNumber: json['senderPhoneNumber'] ?? '',
      recentTextMessage: json['recentTextMessage'] ?? '',
      isRead: json['isRead'] ?? false,
      isArchived: json['isArchived'] ?? false,
      time: json['time'] ?? Timestamp.now(),
    );
  }
}
