import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latter/ui/views/chat_view.dart';
import 'package:latter/ui/views/home_view.dart';
import 'package:provider/provider.dart';
import './views/contacts_view.dart';

class Router {
    static Route<dynamic> generateRoute({ RouteSettings settings, BuildContext context}) {

        switch (settings.name) {
            case '/':
                return MaterialPageRoute(builder: (BuildContext context) => HomeView());
            case '/login':
                return MaterialPageRoute(builder: (_) => Scaffold(
                    body: Center(
                        child: Text('Login'),
                    ),
                ));
            case '/contacts':
                return MaterialPageRoute(builder: (BuildContext context) => ContactsView());
            case '/chat':
                return MaterialPageRoute(builder: (BuildContext context) => ChatView(conversation: settings.arguments,));
            default:
                return MaterialPageRoute(builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route definded for ${settings.name}'),
                    ),
                ));
        }
    }
}