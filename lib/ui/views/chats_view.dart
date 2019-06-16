import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/services/authentication_service.dart';
import 'package:latter/core/services/conversation_service.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:latter/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ChatsView extends StatefulWidget {
  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  Widget _buildChats(AsyncSnapshot<Iterable<Conversation>> snapshot) {
    Iterable<Conversation> conversations = snapshot.data;

    if (!snapshot.hasData) {
      return Text('Loading');
    }

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        Conversation conversation = conversations.elementAt(index);
        EdgeInsets padding = index == 0
          ? EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0)
          : EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0);

        return ListTile(
          contentPadding: padding,
          title: Text(conversation.title, style: subhead,),
          subtitle: Text(conversation.lastMessage, style: body2TextStyle,),
          onTap: () {
            Navigator.pushNamed(context, '/chat', arguments: conversation);
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    FirebaseUser user = Provider.of<FirebaseUser>(context);
    ConversationService conversationService = Provider.of<ConversationService>(context);

    if (user != null) {
      return Container(
        child: StreamBuilder(
          stream: conversationService.streamConversations(user.uid),
          builder: (BuildContext context, AsyncSnapshot<Iterable<Conversation>> snapshot) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Chats',
              ),
              backgroundColor: Colors.white,
              body: _buildChats(snapshot),
            );
          },
        ),
      );
    } else {
      return Container(
        color: Colors.white,
      );
    }
  }
}
