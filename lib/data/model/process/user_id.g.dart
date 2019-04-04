// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_id;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserId> _$userIdSerializer = new _$UserIdSerializer();

class _$UserIdSerializer implements StructuredSerializer<UserId> {
  @override
  final Iterable<Type> types = const [UserId, _$UserId];
  @override
  final String wireName = 'UserId';

  @override
  Iterable serialize(Serializers serializers, UserId object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UserId deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserIdBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserId extends UserId {
  @override
  final String userId;

  factory _$UserId([void updates(UserIdBuilder b)]) =>
      (new UserIdBuilder()..update(updates)).build();

  _$UserId._({this.userId}) : super._() {
    if (userId == null) {
      throw new BuiltValueNullFieldError('UserId', 'userId');
    }
  }

  @override
  UserId rebuild(void updates(UserIdBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserIdBuilder toBuilder() => new UserIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserId && userId == other.userId;
  }

  @override
  int get hashCode {
    return $jf($jc(0, userId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserId')..add('userId', userId))
        .toString();
  }
}

class UserIdBuilder implements Builder<UserId, UserIdBuilder> {
  _$UserId _$v;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  UserIdBuilder();

  UserIdBuilder get _$this {
    if (_$v != null) {
      _userId = _$v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserId other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserId;
  }

  @override
  void update(void updates(UserIdBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserId build() {
    final _$result = _$v ?? new _$UserId._(userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
