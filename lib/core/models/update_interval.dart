import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'update_interval.g.dart';

abstract class UpdateInterval implements Built<UpdateInterval, UpdateIntervalBuilder> {
  static Serializer<UpdateInterval> get serializer => _$updateIntervalSerializer;

  Duration get remaining;
  bool get shouldUpdate;

  @nullable
  DateTime get lastUpdate;

  UpdateInterval._();

  factory UpdateInterval([updates(UpdateIntervalBuilder b)]) = _$UpdateInterval;
}