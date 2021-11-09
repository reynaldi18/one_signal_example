import 'package:json_annotation/json_annotation.dart';
import 'package:one_signal_example/src/models/chat_message.dart';

part 'chat_thread.g.dart';

@JsonSerializable()
class ChatThread {
  @JsonKey(name: 'sender_id')
  String? senderId;
  @JsonKey(name: 'sender_name')
  String? senderName;
  @JsonKey(name: 'receiver_id')
  String? receiverId;
  @JsonKey(name: 'receiver_name')
  String? receiverName;
  @JsonKey(name: 'chats')
  List<ChatMessage>? chats;

  ChatThread({
    this.senderId,
    this.senderName,
    this.receiverId,
    this.receiverName,
    this.chats
  });

  factory ChatThread.fromJson(Map<String, dynamic> json) => _$ChatThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ChatThreadToJson(this);
}
