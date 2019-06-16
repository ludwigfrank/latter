// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Conversation> _$conversationSerializer =
    new _$ConversationSerializer();

class _$ConversationSerializer implements StructuredSerializer<Conversation> {
  @override
  final Iterable<Type> types = const [Conversation, _$Conversation];
  @override
  final String wireName = 'Conversation';

  @override
  Iterable serialize(Serializers serializers, Conversation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'lastMessage',
      serializers.serialize(object.lastMessage,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'participantIds',
      serializers.serialize(object.participantIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  Conversation deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ConversationBuilder();

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
        case 'lastMessage':
          result.lastMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'participantIds':
          result.participantIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$Conversation extends Conversation {
  @override
  final String id;
  @override
  final String lastMessage;
  @override
  final String title;
  @override
  final BuiltList<String> participantIds;

  factory _$Conversation([void Function(ConversationBuilder) updates]) =>
      (new ConversationBuilder()..update(updates)).build();

  _$Conversation._({this.id, this.lastMessage, this.title, this.participantIds})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Conversation', 'id');
    }
    if (lastMessage == null) {
      throw new BuiltValueNullFieldError('Conversation', 'lastMessage');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Conversation', 'title');
    }
    if (participantIds == null) {
      throw new BuiltValueNullFieldError('Conversation', 'participantIds');
    }
  }

  @override
  Conversation rebuild(void Function(ConversationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConversationBuilder toBuilder() => new ConversationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Conversation &&
        id == other.id &&
        lastMessage == other.lastMessage &&
        title == other.title &&
        participantIds == other.participantIds;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), lastMessage.hashCode), title.hashCode),
        participantIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Conversation')
          ..add('id', id)
          ..add('lastMessage', lastMessage)
          ..add('title', title)
          ..add('participantIds', participantIds))
        .toString();
  }
}

class ConversationBuilder
    implements Builder<Conversation, ConversationBuilder> {
  _$Conversation _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _lastMessage;
  String get lastMessage => _$this._lastMessage;
  set lastMessage(String lastMessage) => _$this._lastMessage = lastMessage;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<String> _participantIds;
  ListBuilder<String> get participantIds =>
      _$this._participantIds ??= new ListBuilder<String>();
  set participantIds(ListBuilder<String> participantIds) =>
      _$this._participantIds = participantIds;

  ConversationBuilder();

  ConversationBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _lastMessage = _$v.lastMessage;
      _title = _$v.title;
      _participantIds = _$v.participantIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Conversation other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Conversation;
  }

  @override
  void update(void Function(ConversationBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Conversation build() {
    _$Conversation _$result;
    try {
      _$result = _$v ??
          new _$Conversation._(
              id: id,
              lastMessage: lastMessage,
              title: title,
              participantIds: participantIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'participantIds';
        participantIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Conversation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
