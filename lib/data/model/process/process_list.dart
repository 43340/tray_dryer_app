library process_list;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tray_dryer_app/data/model/process/process_id.dart';
import 'package:tray_dryer_app/data/model/process/user_id.dart';
import 'package:tray_dryer_app/data/model/serializer/serializers.dart';

part 'process_list.g.dart';

abstract class ProcessList implements Built<ProcessList, ProcessListBuilder> {
  @nullable
  ProcessId get processId;
  String get name;
  int get setTemp;
  int get cookTime;
  int get readInt;
  UserId get userId;
  String get timeStamp;

  ProcessList._();

  factory ProcessList([updates(ProcessListBuilder b)]) = _$ProcessList;

  String toJson() {
    return json.encode(serializers.serializeWith(ProcessList.serializer, this));
  }

  static ProcessList fromJson(String jsonString) {
    return serializers.deserializeWith(
        ProcessList.serializer, json.decode(jsonString));
  }

  static Serializer<ProcessList> get serializer => _$processListSerializer;
}
