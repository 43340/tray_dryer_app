// GENERATED CODE - DO NOT MODIFY BY HAND

part of process_list;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProcessList> _$processListSerializer = new _$ProcessListSerializer();

class _$ProcessListSerializer implements StructuredSerializer<ProcessList> {
  @override
  final Iterable<Type> types = const [ProcessList, _$ProcessList];
  @override
  final String wireName = 'ProcessList';

  @override
  Iterable serialize(Serializers serializers, ProcessList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'setTemp',
      serializers.serialize(object.setTemp, specifiedType: const FullType(int)),
      'cookTime',
      serializers.serialize(object.cookTime,
          specifiedType: const FullType(int)),
      'readInt',
      serializers.serialize(object.readInt, specifiedType: const FullType(int)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(UserId)),
      'timeStamp',
      serializers.serialize(object.timeStamp,
          specifiedType: const FullType(String)),
    ];
    if (object.processId != null) {
      result
        ..add('processId')
        ..add(serializers.serialize(object.processId,
            specifiedType: const FullType(ProcessId)));
    }

    return result;
  }

  @override
  ProcessList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProcessListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'processId':
          result.processId.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProcessId)) as ProcessId);
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'setTemp':
          result.setTemp = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'cookTime':
          result.cookTime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'readInt':
          result.readInt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userId':
          result.userId.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserId)) as UserId);
          break;
        case 'timeStamp':
          result.timeStamp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProcessList extends ProcessList {
  @override
  final ProcessId processId;
  @override
  final String name;
  @override
  final int setTemp;
  @override
  final int cookTime;
  @override
  final int readInt;
  @override
  final UserId userId;
  @override
  final String timeStamp;

  factory _$ProcessList([void updates(ProcessListBuilder b)]) =>
      (new ProcessListBuilder()..update(updates)).build();

  _$ProcessList._(
      {this.processId,
      this.name,
      this.setTemp,
      this.cookTime,
      this.readInt,
      this.userId,
      this.timeStamp})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'name');
    }
    if (setTemp == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'setTemp');
    }
    if (cookTime == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'cookTime');
    }
    if (readInt == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'readInt');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'userId');
    }
    if (timeStamp == null) {
      throw new BuiltValueNullFieldError('ProcessList', 'timeStamp');
    }
  }

  @override
  ProcessList rebuild(void updates(ProcessListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProcessListBuilder toBuilder() => new ProcessListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcessList &&
        processId == other.processId &&
        name == other.name &&
        setTemp == other.setTemp &&
        cookTime == other.cookTime &&
        readInt == other.readInt &&
        userId == other.userId &&
        timeStamp == other.timeStamp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, processId.hashCode), name.hashCode),
                        setTemp.hashCode),
                    cookTime.hashCode),
                readInt.hashCode),
            userId.hashCode),
        timeStamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProcessList')
          ..add('processId', processId)
          ..add('name', name)
          ..add('setTemp', setTemp)
          ..add('cookTime', cookTime)
          ..add('readInt', readInt)
          ..add('userId', userId)
          ..add('timeStamp', timeStamp))
        .toString();
  }
}

class ProcessListBuilder implements Builder<ProcessList, ProcessListBuilder> {
  _$ProcessList _$v;

  ProcessIdBuilder _processId;
  ProcessIdBuilder get processId =>
      _$this._processId ??= new ProcessIdBuilder();
  set processId(ProcessIdBuilder processId) => _$this._processId = processId;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _setTemp;
  int get setTemp => _$this._setTemp;
  set setTemp(int setTemp) => _$this._setTemp = setTemp;

  int _cookTime;
  int get cookTime => _$this._cookTime;
  set cookTime(int cookTime) => _$this._cookTime = cookTime;

  int _readInt;
  int get readInt => _$this._readInt;
  set readInt(int readInt) => _$this._readInt = readInt;

  UserIdBuilder _userId;
  UserIdBuilder get userId => _$this._userId ??= new UserIdBuilder();
  set userId(UserIdBuilder userId) => _$this._userId = userId;

  String _timeStamp;
  String get timeStamp => _$this._timeStamp;
  set timeStamp(String timeStamp) => _$this._timeStamp = timeStamp;

  ProcessListBuilder();

  ProcessListBuilder get _$this {
    if (_$v != null) {
      _processId = _$v.processId?.toBuilder();
      _name = _$v.name;
      _setTemp = _$v.setTemp;
      _cookTime = _$v.cookTime;
      _readInt = _$v.readInt;
      _userId = _$v.userId?.toBuilder();
      _timeStamp = _$v.timeStamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcessList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProcessList;
  }

  @override
  void update(void updates(ProcessListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProcessList build() {
    _$ProcessList _$result;
    try {
      _$result = _$v ??
          new _$ProcessList._(
              processId: _processId?.build(),
              name: name,
              setTemp: setTemp,
              cookTime: cookTime,
              readInt: readInt,
              userId: userId.build(),
              timeStamp: timeStamp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'processId';
        _processId?.build();

        _$failedField = 'userId';
        userId.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProcessList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
