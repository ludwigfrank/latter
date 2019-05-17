import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './widgets/chats_appbar.dart';

class ChatsPage extends StatefulWidget {
    final FirebaseUser _userRepository;

    static String title = 'Chats';

    ChatsPage({Key key, @required FirebaseUser userRepository})
        : assert(userRepository != null), _userRepository = userRepository, super(key: key);

    @override
    _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
    FirebaseUser get _userRepository => widget._userRepository;


    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                ChatsAppbar()
            ],
        );
    }
}
