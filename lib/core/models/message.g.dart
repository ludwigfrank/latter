// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Message> _$messageSerializer = new _$MessageSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable serialize(Serializers serializers, Message object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'authorId',
      serializers.serialize(object.authorId,
          specifiedType: const FullType(String)),
      'authorDisplayName',
      serializers.serialize(object.authorDisplayName,
          specifiedType: const FullType(String)),
      'created',
      serializers.serialize(object.created,
          specifiedType: const FullType(String)),
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(String)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(Timestamp)),
      'isImportant',
      serializers.serialize(object.isImportant,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authorId':
          result.authorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authorDisplayName':
          result.authorDisplayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'isImportant':
          result.isImportant = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Message extends Message {
  @override
  final String id;
  @override
  final String authorId;
  @override
  final String authorDisplayName;
  @override
  final String created;
  @override
  final String value;
  @override
  final Timestamp timestamp;
  @override
  final bool isImportant;

  factory _$Message([void Function(MessageBuilder) updates]) =>
      (new MessageBuilder()..update(updates)).build();

  _$Message._(
      {this.id,
      this.authorId,
      this.authorDisplayName,
      this.created,
      this.value,
      this.timestamp,
      this.isImportant})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Message', 'id');
    }
    if (authorId == null) {
      throw new BuiltValueNullFieldError('Message', 'authorId');
    }
    if (authorDisplayName == null) {
      throw new BuiltValueNullFieldError('Message', 'authorDisplayName');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('Message', 'created');
    }
    if (value == null) {
      throw new BuiltValueNullFieldError('Message', 'value');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('Message', 'timestamp');
    }
    if (isImportant == null) {
      throw new BuiltValueNullFieldError('Message', 'isImportant');
    }
  }

  @override
  Message rebuild(void Function(MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
        id == other.id &&
        authorId == other.authorId &&
        authorDisplayName == other.authorDisplayName &&
        created == other.created &&
        value == other.value &&
        timestamp == other.timestamp &&
        isImportant == other.isImportant;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), authorId.hashCode),
                        authorDisplayName.hashCode),
                    created.hashCode),
                value.hashCode),
            timestamp.hashCode),
        isImportant.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Message')
          ..add('id', id)
          ..add('authorId', authorId)
          ..add('authorDisplayName', authorDisplayName)
          ..add('created', created)
          ..add('value', value)
          ..add('timestamp', timestamp)
          ..add('isImportant', isImportant))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _authorId;
  String get authorId => _$this._authorId;
  set authorId(String authorId) => _$this._authorId = authorId;

  String _authorDisplayName;
  String get authorDisplayName => _$this._authorDisplayName;
  set authorDisplayName(String authorDisplayName) =>
      _$this._authorDisplayName = authorDisplayName;

  String _created;
  String get created => _$this._created;
  set created(String created) => _$this._created = created;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  bool _isImportant;
  bool get isImportant => _$this._isImportant;
  set isImportant(bool isImportant) => _$this._isImportant = isImportant;

  MessageBuilder();

  MessageBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _authorId = _$v.authorId;
      _authorDisplayName = _$v.authorDisplayName;
      _created = _$v.created;
      _value = _$v.value;
      _timestamp = _$v.timestamp;
      _isImportant = _$v.isImportant;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Message;
  }

  @override
  void update(void Function(MessageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Message build() {
    final _$result = _$v ??
        new _$Message._(
            id: id,
            authorId: authorId,
            authorDisplayName: authorDisplayName,
            created: created,
            value: value,
            timestamp: timestamp,
            isImportant: isImportant);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
