import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/conversation.dart';

class ChatView extends StatefulWidget {
    final Conversation conversation;

    ChatView({ Key key, @required this.conversation }) : super(key: key);

    @override
    _ChatViewState createState() => _ChatViewState(conversation);
}

class _ChatViewState extends State<ChatView> {
    Conversation conversation;
    _ChatViewState(this.conversation);

    @override
    Widget build(BuildContext context) {
        final String conversationTitle = conversation.participants.length > 2 ? conversation.participants[0].name : 'Group';


        return Scaffold(
            appBar: AppBar(
                title: Text(conversation.participants[0].name),
            ),
            body: Center(child: Text('Hello')),
        );
    }
}
