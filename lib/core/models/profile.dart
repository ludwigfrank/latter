import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:latter/core/models/conversation.dart';


part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
    static Serializer<Profile> get serializer => _$profileSerializer;

    String get id;
    String get displayName;
    String get phoneNumber;

    @nullable
    BuiltMap<String, Conversation> get conversations;

    // Contacts are saved in a separate collection
    @nullable
    BuiltMap<String, Profile> get contacts;

    Profile._();

    factory Profile([updates(ProfileBuilder b)]) = _$Profile;
}