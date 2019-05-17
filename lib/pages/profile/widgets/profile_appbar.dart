import 'package:flutter/material.dart';
import 'package:latter/styles/custom_icons_28pt.dart';

class ProfileAppbar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                AppBar(
                    title: Text('Profile', style: TextStyle(color: Colors.blueGrey[900]),),
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    actions: <Widget>[
                        IconButton(
                            icon: Icon(CustomIcons28pt.compose, color: Colors.black, size: 28.0,),
                            onPressed: () => {},
                        )
                    ],
                ),
                Container(
                    height: 0.5,
                    color: Colors.blueGrey[100],
                ),
            ],
        );
    }
}