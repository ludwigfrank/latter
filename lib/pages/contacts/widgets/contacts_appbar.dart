import 'package:flutter/material.dart';

class ContactsAppbar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                AppBar(
                    title: Text('Contacts', style: TextStyle(color: Colors.black87),),
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                ),
                Container(
                    height: 0.5,
                    color: Colors.blueGrey[100],
                ),
            ],
        );
    }
}