import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'player_id')
  String? playerId;
  @JsonKey(name: 'uid')
  String? uid;
  @JsonKey(name: 'role')
  String? role;

  User({
    this.name,
    this.email,
    this.playerId,
    this.uid,
    this.role
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
