import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/conversation_service.dart';
import 'package:latter/core/services/interval_service.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:latter/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:latter/ui/widgets/la_message/la_message.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';


class ChatView extends StatefulWidget {

  ChatView({ Key key, this.conversation }) : super(key: key);

  final Conversation conversation;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TextEditingController textEditingController;
  AccelerometerEvent acceleration;

  @override
  void initState () {

    textEditingController = TextEditingController();

    accelerometerEvents.listen((AccelerometerEvent event) {
      if(event.x > 79 && textEditingController.text.length > 10) {
        handleMessageSend(isImportant: true);
        SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
      }
    });

    super.initState();
  }


  Widget _buildInput () {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                controller: textEditingController,
                maxLines: 1,
                style: body1TextStyle,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none
                    )
                  ),
                  contentPadding: EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0),
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  enabledBorder: null
                )
            )
          ),
          IconButton(icon: Icon(Icons.send, color: Colors.deepPurpleAccent),onPressed: () { handleMessageSend(isImportant: false); },),
        ],
      )
    );
  }

  Widget _buildMessages (AsyncSnapshot<Iterable<Message>> snapshot) {
    Iterable<Message> messages = snapshot.data;
    IntervalService intervalService = Provider.of<IntervalService>(context);

    if (!snapshot.hasData) {
      return Text('Loading');
    }

    return StreamBuilder<UpdateInterval>(
      stream: intervalService.interval,
      builder: (context, snapshot) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 550),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: AnimatedList(
                initialItemCount: messages.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder:  (BuildContext context, int index, Animation<double> animation)  {
                  Message message = messages.elementAt(index);
                  EdgeInsets padding = index == 0
                    ? EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0)
                    : EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0);

                  bool isIdle = false;

                  if (snapshot.hasData) {
                    isIdle = DateTime.parse(message.created).isBefore(snapshot.data.lastUpdate);
                  }

                  return LaMessage(message: message, animation: animation, isIdle: isIdle,);
                }
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Conversation conversation = widget.conversation;


    return Scaffold(
      appBar: CustomAppBar(
        title: conversation.title
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: StreamBuilder(
          stream: ConversationService().streamConversationMessages(conversation.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                _buildMessages(snapshot),
                Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: AnimatedContainer(child: _buildInput(), duration: Duration(milliseconds: 250),)
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void handleMessageSend ({ isImportant = false }) {
    String text = textEditingController.text;

    Message message = Message((b) => b
      ..value = text
      ..authorId = 'DE0JPqhhZdbpoY0xBhSea3ShKO23'
      ..authorDisplayName = 'Ludwig Frank'
      ..created = DateTime.now().toUtc().toIso8601String()
      ..timestamp = Timestamp.now()
      ..id = DateTime.now().toUtc().toIso8601String() + '_' +'DE0JPqhhZdbpoY0xBhSea3ShKO23'
      ..isImportant = isImportant
    );

    ConversationService().sendMessage(widget.conversation, message);
    textEditingController.clear();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
