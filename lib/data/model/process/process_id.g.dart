// GENERATED CODE - DO NOT MODIFY BY HAND

part of process_id;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProcessId> _$processIdSerializer = new _$ProcessIdSerializer();

class _$ProcessIdSerializer implements StructuredSerializer<ProcessId> {
  @override
  final Iterable<Type> types = const [ProcessId, _$ProcessId];
  @override
  final String wireName = 'ProcessId';

  @override
  Iterable serialize(Serializers serializers, ProcessId object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'processId',
      serializers.serialize(object.processId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ProcessId deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProcessIdBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'processId':
          result.processId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProcessId extends ProcessId {
  @override
  final String processId;

  factory _$ProcessId([void updates(ProcessIdBuilder b)]) =>
      (new ProcessIdBuilder()..update(updates)).build();

  _$ProcessId._({this.processId}) : super._() {
    if (processId == null) {
      throw new BuiltValueNullFieldError('ProcessId', 'processId');
    }
  }

  @override
  ProcessId rebuild(void updates(ProcessIdBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProcessIdBuilder toBuilder() => new ProcessIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcessId && processId == other.processId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, processId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProcessId')
          ..add('processId', processId))
        .toString();
  }
}

class ProcessIdBuilder implements Builder<ProcessId, ProcessIdBuilder> {
  _$ProcessId _$v;

  String _processId;
  String get processId => _$this._processId;
  set processId(String processId) => _$this._processId = processId;

  ProcessIdBuilder();

  ProcessIdBuilder get _$this {
    if (_$v != null) {
      _processId = _$v.processId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcessId other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProcessId;
  }

  @override
  void update(void updates(ProcessIdBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ProcessId build() {
    final _$result = _$v ?? new _$ProcessId._(processId: processId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
