import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/message.dart';
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/interval_service.dart';
import 'package:latter/ui/styles/colors.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:provider/provider.dart';

class LaMessage extends StatelessWidget {
  final Message message;
  final Animation animation;
  final bool isIdle;
  LaMessage({this.message, this.animation, this.isIdle });

  Widget _buildImportantIndicator() {
    var assetImage = new AssetImage('assets/important.png');
    var image = new Image(image: assetImage, width: 18.0, height: 18.0,);

    if (message.isImportant) {
      return Positioned(
        top: -8.0,
        left: -8.0,
        child: Container(
          child: image,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 4.0,
                spreadRadius: .0,
                offset: Offset(
                  0.0,
                  4.0,
                ),
              )
            ]
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    IntervalService intervalService = Provider.of<IntervalService>(context);

    bool isUser = message.authorId == user.uid;

    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isUser ? message.isImportant ? LaColors.activeBlue : !isIdle ? Colors.white : LaColors.activeBlue : Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.blueGrey[50],
                    width: 1
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Text(
                    message.value,
                    style: body1TextStyle.copyWith(color: isUser && isIdle || message.isImportant ? Colors.white : Colors.blueGrey[900], fontWeight:  isUser && isIdle || message.isImportant ? FontWeight.w400 : FontWeight.w500),
                  ),
                ),
              ),
              _buildImportantIndicator()
            ],
          ),
        )
      ],
    );
  }
}
