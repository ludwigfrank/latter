import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latter/core/models/profile.dart';
import 'package:meta/meta.dart';


class Chat {
    final String id;
    final List<Profile> participants;
    final List<String> messages;

    Chat({ this.id, this.messages, this.participants});
    
    factory Chat.fromFirestore(DocumentSnapshot doc) {
        Map data = doc.data;

        return Chat(
            id: doc.documentID,
            participants: data['participants'],
            messages: data['messages']
        )
    }
}