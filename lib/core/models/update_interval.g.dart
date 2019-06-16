// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_interval.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UpdateInterval> _$updateIntervalSerializer =
    new _$UpdateIntervalSerializer();

class _$UpdateIntervalSerializer
    implements StructuredSerializer<UpdateInterval> {
  @override
  final Iterable<Type> types = const [UpdateInterval, _$UpdateInterval];
  @override
  final String wireName = 'UpdateInterval';

  @override
  Iterable serialize(Serializers serializers, UpdateInterval object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'remaining',
      serializers.serialize(object.remaining,
          specifiedType: const FullType(Duration)),
      'shouldUpdate',
      serializers.serialize(object.shouldUpdate,
          specifiedType: const FullType(bool)),
    ];
    if (object.lastUpdate != null) {
      result
        ..add('lastUpdate')
        ..add(serializers.serialize(object.lastUpdate,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  UpdateInterval deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpdateIntervalBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'remaining':
          result.remaining = serializers.deserialize(value,
              specifiedType: const FullType(Duration)) as Duration;
          break;
        case 'shouldUpdate':
          result.shouldUpdate = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'lastUpdate':
          result.lastUpdate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$UpdateInterval extends UpdateInterval {
  @override
  final Duration remaining;
  @override
  final bool shouldUpdate;
  @override
  final DateTime lastUpdate;

  factory _$UpdateInterval([void Function(UpdateIntervalBuilder) updates]) =>
      (new UpdateIntervalBuilder()..update(updates)).build();

  _$UpdateInterval._({this.remaining, this.shouldUpdate, this.lastUpdate})
      : super._() {
    if (remaining == null) {
      throw new BuiltValueNullFieldError('UpdateInterval', 'remaining');
    }
    if (shouldUpdate == null) {
      throw new BuiltValueNullFieldError('UpdateInterval', 'shouldUpdate');
    }
  }

  @override
  UpdateInterval rebuild(void Function(UpdateIntervalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateIntervalBuilder toBuilder() =>
      new UpdateIntervalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateInterval &&
        remaining == other.remaining &&
        shouldUpdate == other.shouldUpdate &&
        lastUpdate == other.lastUpdate;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, remaining.hashCode), shouldUpdate.hashCode),
        lastUpdate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UpdateInterval')
          ..add('remaining', remaining)
          ..add('shouldUpdate', shouldUpdate)
          ..add('lastUpdate', lastUpdate))
        .toString();
  }
}

class UpdateIntervalBuilder
    implements Builder<UpdateInterval, UpdateIntervalBuilder> {
  _$UpdateInterval _$v;

  Duration _remaining;
  Duration get remaining => _$this._remaining;
  set remaining(Duration remaining) => _$this._remaining = remaining;

  bool _shouldUpdate;
  bool get shouldUpdate => _$this._shouldUpdate;
  set shouldUpdate(bool shouldUpdate) => _$this._shouldUpdate = shouldUpdate;

  DateTime _lastUpdate;
  DateTime get lastUpdate => _$this._lastUpdate;
  set lastUpdate(DateTime lastUpdate) => _$this._lastUpdate = lastUpdate;

  UpdateIntervalBuilder();

  UpdateIntervalBuilder get _$this {
    if (_$v != null) {
      _remaining = _$v.remaining;
      _shouldUpdate = _$v.shouldUpdate;
      _lastUpdate = _$v.lastUpdate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateInterval other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UpdateInterval;
  }

  @override
  void update(void Function(UpdateIntervalBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UpdateInterval build() {
    final _$result = _$v ??
        new _$UpdateInterval._(
            remaining: remaining,
            shouldUpdate: shouldUpdate,
            lastUpdate: lastUpdate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
