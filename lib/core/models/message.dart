import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
    static Serializer<Message> get serializer => _$messageSerializer;

    String get id;
    String get authorId;
    String get authorDisplayName;
    String get created;
    String get value;
    Timestamp get timestamp;
    bool get isImportant;

    Message._();

    factory Message([updates(MessageBuilder b)]) = _$Message;
}