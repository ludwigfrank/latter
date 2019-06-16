import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latter/locator.dart';
import 'package:latter/providers.dart';
import 'package:latter/ui/router.dart';
import 'package:provider/provider.dart';


main() {
    setupLocator();
    runApp(App());
}

class App extends StatefulWidget {
    State<App> createState() => _AppState();
}

class _AppState extends State<App> {


    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: providers,
            child: MaterialApp(
              title: 'Latter',
              theme: ThemeData(),
              initialRoute: '/',
              onGenerateRoute: (settings) => Router.generateRoute(settings: settings, context: context),
          ),
        );
    }
}