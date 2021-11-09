// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      email: json['email'] as String?,
      playerId: json['player_id'] as String?,
      uid: json['uid'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'player_id': instance.playerId,
      'uid': instance.uid,
      'role': instance.role,
    };
