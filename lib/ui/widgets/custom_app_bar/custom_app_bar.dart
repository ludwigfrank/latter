import 'package:flutter/material.dart';
import 'package:latter/ui/styles/text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    CustomAppBar({
        Key key,
        this.title,
        this.bottom
    }) : super(key: key);

    final PreferredSizeWidget bottom;
    final String title;

    @override
    Widget build(BuildContext context) {
        return AppBar(
            title: Text(title, style: header4TextStyle,),
            elevation: 0.0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(child: Container(color: Colors.blueGrey[50], height: 1.0,), preferredSize: Size.fromHeight(1.0))
        );
    }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
}
