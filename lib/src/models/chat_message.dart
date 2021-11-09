import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  @JsonKey(name: 'customer')
  bool customer;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'read')
  bool read;

  ChatMessage({
    this.customer = true,
    this.message,
    this.createdAt,
    this.read = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
