import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/interval_service.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:provider/provider.dart';

class LaMessage extends StatelessWidget {
  final Message message;
  final Animation animation;
  final bool isIdle;
  LaMessage({this.message, this.animation, this.isIdle });

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    IntervalService intervalService = Provider.of<IntervalService>(context);

    bool isUser = message.authorId == user.uid;
    bool _isIdle = isIdle && !message.isImportant;

    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: _isIdle ? Colors.blueGrey[50] : Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.blueGrey[50],
                    width: 1
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    message.value,
                    style: body1TextStyle,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                  image: DecorationImage(
                    image: AssetImage('lib/assets/img/important.png')
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
