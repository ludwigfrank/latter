import 'package:flutter/material.dart';
import 'package:latter/ui/styles/custom_icons.dart';
import 'package:latter/ui/views/profile_view.dart';

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


Widget _buildChats(BuildContext context) {
    return Center(
        child: OutlineButton(
            child: Text('Contacts',),
            onPressed: () { Navigator.pushNamed(context, '/contacts');},
        ),
    );
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
            Screen(title: 'Chats', icon: Icon(CustomIcons.chat), component: _buildChats(context)),
            Screen(title: 'Profile', icon: Icon(CustomIcons.profile), component: ProfileView())
        ];

        return Scaffold(
            body: _views[_selectedIndex].component,
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
