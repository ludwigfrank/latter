import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/profile.dart';

part 'conversation.g.dart';

abstract class Conversation implements Built<Conversation, ConversationBuilder> {
    static Serializer<Conversation> get serializer => _$conversationSerializer;

    String get id;
    String get lastMessage;
    String get title;
    BuiltList<String> get participantIds;

    Conversation._();

    factory Conversation([updates(ConversationBuilder b)]) = _$Conversation;
}