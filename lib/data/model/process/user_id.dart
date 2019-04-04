library user_id;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tray_dryer_app/data/model/serializer/serializers.dart';

part 'user_id.g.dart';

abstract class UserId implements Built<UserId, UserIdBuilder> {
  String get userId;

  UserId._();

  factory UserId([updates(UserIdBuilder b)]) = _$UserId;

  String toJson() {
    return json.encode(serializers.serializeWith(UserId.serializer, this));
  }

  static UserId fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserId.serializer, json.decode(jsonString));
  }

  static Serializer<UserId> get serializer => _$userIdSerializer;
}
