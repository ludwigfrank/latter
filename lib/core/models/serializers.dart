library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'package:built_value/standard_json_plugin.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/profile.dart';
import 'package:latter/core/serializers/timestamp_serializer.dart';


part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
    Message,
    Conversation,
    Profile,
])

final Serializers serializers = _$serializers;
final standardSerializers = (serializers.toBuilder()..add(new TimestampSerializer())..addPlugin(new StandardJsonPlugin())).build();