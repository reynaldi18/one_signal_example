// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatThread _$ChatThreadFromJson(Map<String, dynamic> json) => ChatThread(
      senderId: json['sender_id'] as String?,
      senderName: json['sender_name'] as String?,
      receiverId: json['receiver_id'] as String?,
      receiverName: json['receiver_name'] as String?,
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatThreadToJson(ChatThread instance) =>
    <String, dynamic>{
      'sender_id': instance.senderId,
      'sender_name': instance.senderName,
      'receiver_id': instance.receiverId,
      'receiver_name': instance.receiverName,
      'chats': instance.chats,
    };
