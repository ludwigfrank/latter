import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/services/authentication_service.dart';
import 'package:latter/ui/styles/custom_icons.dart';
import 'package:latter/ui/views/chats_view.dart';
import 'package:latter/ui/views/profile_view.dart';
import 'package:latter/ui/widgets/la_chat_timer/la_chat_timer.dart';
import 'package:phone_number/phone_number.dart';

import '../../locator.dart';

class Screen {
    String title;
    Icon icon;
    Widget component;
    dynamic appbar;

    Screen({ this.title, this.icon, this.component, this.appbar });
}

class HomeView extends StatefulWidget {
    @override
    _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {
    int _selectedIndex = 1;

    _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {


        final List<Screen> _views = [
            Screen(title: 'Calendar', icon: Icon(CustomIcons.calendar), component: Container(color: Colors.deepOrangeAccent,)),
            Screen(title: 'Chats', icon: Icon(CustomIcons.chat), component: ChatsView()),
            Screen(title: 'Profile', icon: Icon(CustomIcons.profile), component: ProfileView())
        ];

        return Scaffold(
            body: _views[_selectedIndex].component,
            floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                child: Container(child: Center(child: LaChatTimer()), width: 64.0, height: 64.0),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: _views.map((screen) {
                    return BottomNavigationBarItem(
                        icon: screen.icon,
                        title: Text(screen.title, style: TextStyle(fontWeight: FontWeight.w500))
                    );
                }).toList(),
                iconSize: 26.0,
                currentIndex: _selectedIndex,
                fixedColor: Colors.deepPurpleAccent,
                onTap: _onItemTapped,
            ),
        );
    }
}
