import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/serializers.dart';


class ConversationService {
  final Firestore _db = Firestore.instance;

  Stream<Conversation> streamConversationFromParticipant(String participantId) {
    Stream<Conversation> documents;

    try {
      documents = _db
        .collection('conversations')
        .where('participantIds', arrayContains: participantId)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot snapshot) {
        Map<String, dynamic> values = snapshot.documents.first.data;

        return new Conversation((b) => b
          ..id = values['id']
          ..title = values['title']
          ..participantIds = values['participantIds']
          ..lastMessage = values['lastMessage']
        );
      });

    } catch (error) {
      print(error);
    }

    return documents;
  }

  Stream<Iterable<Conversation>> streamConversations(String userId) {
    CollectionReference conversations = _db.collection('conversations');

    return conversations
      .where('participantIds', arrayContains: userId)
      .snapshots()
      .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot snapshot) {
        Map<String, dynamic> values = snapshot.data;

        return new Conversation((b) => b
          ..id = values['id']
          ..title = values['title']
          ..participantIds = ListBuilder(values['participantIds'])
          ..lastMessage = values['lastMessage']
        );
      });
    });
  }

  Stream<Iterable<Message>> streamConversationMessages(String conversationId) {
    var messages = _db.collection('conversations').document(conversationId).collection('messages').orderBy('timestamp', descending: true);

    return messages
      .snapshots()
      .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot snapshot) {
        Map<String, dynamic> values = snapshot.data;

        return new Message((b) => b
          ..authorDisplayName = values['authorDisplayName']
          ..authorId = values['authorId']
          ..id = values['id']
          ..timestamp = values['timestamp']
          ..created = values['created']
          ..value = values['value']
          ..isImportant = values['isImportant']
        );
      });
    });
  }


  Stream<Conversation> streamConversation(String id) {
    Stream<Conversation> documents;

    try {
      documents = _db
        .collection('conversations')
        .document(id)
        .snapshots()
        .map((DocumentSnapshot snapshot) => Conversation((b) => b
        ..id = snapshot['id']
      ));
    } catch (error) {
      print(error);
    }

    return documents;
  }

  void sendMessage(Conversation conversation, Message message) {
    CollectionReference messages = _db.collection('conversations').document(conversation.id).collection('messages');

    messages.document(message.id).setData(
      standardSerializers.serializeWith(Message.serializer, message)
    );
  }

  void deleteMessage(Conversation conversation, Message message) {
    CollectionReference messages = _db.collection('conversations').document(conversation.id).collection('messages');

    messages.document(message.id).delete();
  }
}