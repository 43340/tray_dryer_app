library process_id;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tray_dryer_app/data/model/serializer/serializers.dart';

part 'process_id.g.dart';

abstract class ProcessId implements Built<ProcessId, ProcessIdBuilder> {
  String get processId;

  ProcessId._();

  factory ProcessId([updates(ProcessIdBuilder b)]) = _$ProcessId;

  String toJson() {
    return json.encode(serializers.serializeWith(ProcessId.serializer, this));
  }

  static ProcessId fromJson(String jsonString) {
    return serializers.deserializeWith(
        ProcessId.serializer, json.decode(jsonString));
  }

  static Serializer<ProcessId> get serializer => _$processIdSerializer;
}
