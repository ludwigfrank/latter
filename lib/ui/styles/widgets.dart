import 'package:flutter/material.dart';

AppBar buildCustomAppBar({BuildContext context, String title}) {
    return AppBar(
        title: Text(title, style: Theme.of(context).textTheme.title),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
                color: Colors.blueGrey[100],
                height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0))
    );
}
