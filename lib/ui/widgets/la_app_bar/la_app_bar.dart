import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:latter/ui/styles/text.dart';


class LaAppBar extends StatefulWidget implements PreferredSizeWidget {

    LaAppBar({
        Key key,
        this.bottom,
        this.title,
    }) : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

    final String title;

    /// This widget appears across the bottom of the app bar.
    ///
    /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can
    /// be used at the bottom of an app bar.
    ///
    /// See also:
    ///
    ///  * [PreferredSize], which can be used to give an arbitrary widget a preferred size.
    final PreferredSizeWidget bottom;


    /// A size whose height is the sum of [kToolbarHeight] and the [bottom] widget's
    /// preferred height.
    ///
    /// [Scaffold] uses this this size to set its app bar's height.
    @override
    final Size preferredSize;

    @override
    _LaAppBarState createState() => _LaAppBarState();
}

class _LaAppBarState extends State<LaAppBar> {

    @override
    Widget build(BuildContext context) {
        final double topPadding = MediaQuery.of(context).padding.top;

        return Material(
            elevation: 0.0,
            color: Colors.white,
            child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.blueGrey[100],
                            width: 0.5,
                            style: BorderStyle.solid,
                        ),
                    ),
                ),
                child: Center(
                    child: Text(widget.title, style: header4TextStyle,),
                )
            ),
        );
    }
}
