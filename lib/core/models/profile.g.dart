// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Profile> _$profileSerializer = new _$ProfileSerializer();

class _$ProfileSerializer implements StructuredSerializer<Profile> {
  @override
  final Iterable<Type> types = const [Profile, _$Profile];
  @override
  final String wireName = 'Profile';

  @override
  Iterable serialize(Serializers serializers, Profile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'phoneNumber',
      serializers.serialize(object.phoneNumber,
          specifiedType: const FullType(String)),
    ];
    if (object.conversations != null) {
      result
        ..add('conversations')
        ..add(serializers.serialize(object.conversations,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(Conversation)])));
    }
    if (object.contacts != null) {
      result
        ..add('contacts')
        ..add(serializers.serialize(object.contacts,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(Profile)])));
    }
    return result;
  }

  @override
  Profile deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileBuilder();

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
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'conversations':
          result.conversations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(Conversation)
              ])) as BuiltMap);
          break;
        case 'contacts':
          result.contacts.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(Profile)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$Profile extends Profile {
  @override
  final String id;
  @override
  final String displayName;
  @override
  final String phoneNumber;
  @override
  final BuiltMap<String, Conversation> conversations;
  @override
  final BuiltMap<String, Profile> contacts;

  factory _$Profile([void Function(ProfileBuilder) updates]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.id,
      this.displayName,
      this.phoneNumber,
      this.conversations,
      this.contacts})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Profile', 'id');
    }
    if (displayName == null) {
      throw new BuiltValueNullFieldError('Profile', 'displayName');
    }
    if (phoneNumber == null) {
      throw new BuiltValueNullFieldError('Profile', 'phoneNumber');
    }
  }

  @override
  Profile rebuild(void Function(ProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => new ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        id == other.id &&
        displayName == other.displayName &&
        phoneNumber == other.phoneNumber &&
        conversations == other.conversations &&
        contacts == other.contacts;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), displayName.hashCode),
                phoneNumber.hashCode),
            conversations.hashCode),
        contacts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('phoneNumber', phoneNumber)
          ..add('conversations', conversations)
          ..add('contacts', contacts))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  MapBuilder<String, Conversation> _conversations;
  MapBuilder<String, Conversation> get conversations =>
      _$this._conversations ??= new MapBuilder<String, Conversation>();
  set conversations(MapBuilder<String, Conversation> conversations) =>
      _$this._conversations = conversations;

  MapBuilder<String, Profile> _contacts;
  MapBuilder<String, Profile> get contacts =>
      _$this._contacts ??= new MapBuilder<String, Profile>();
  set contacts(MapBuilder<String, Profile> contacts) =>
      _$this._contacts = contacts;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _displayName = _$v.displayName;
      _phoneNumber = _$v.phoneNumber;
      _conversations = _$v.conversations?.toBuilder();
      _contacts = _$v.contacts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Profile;
  }

  @override
  void update(void Function(ProfileBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Profile build() {
    _$Profile _$result;
    try {
      _$result = _$v ??
          new _$Profile._(
              id: id,
              displayName: displayName,
              phoneNumber: phoneNumber,
              conversations: _conversations?.build(),
              contacts: _contacts?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'conversations';
        _conversations?.build();
        _$failedField = 'contacts';
        _contacts?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Profile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
