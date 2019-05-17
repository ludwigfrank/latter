import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latter/pages/chats/chats.dart';
import 'package:latter/state/authentication/user_repository.dart';
import 'package:latter/styles/custom_icons.dart';
import 'package:latter/pages/profile/profile.dart';
import 'package:latter/pages/contacts/contacts.dart';

import 'package:latter/styles/widgets.dart';

class Screen {
    String title;
    Icon icon;
    Widget component;
    dynamic appbar;

    Screen({ this.title, this.icon, this.component, this.appbar });
}

class HomePage extends StatefulWidget {
    final UserRepository _userRepository;

    HomePage({Key key, @required UserRepository userRepository})
        : assert(userRepository != null), _userRepository = userRepository, super(key: key);

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 1;
    FirebaseUser _userInstance;
    List<Screen> _screens;

    UserRepository get _userRepository => widget._userRepository;

    _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    @override
    void initState() {
        _userRepository.currentUser.then((user) => {
            setState(() {
                _userInstance = user;
                _screens = [
                    Screen(title: 'Calendar', icon: Icon(CustomIcons.calendar), component: ContactsPage()),
                    Screen(title: 'Chats', icon: Icon(CustomIcons.chat), component: ChatsPage(userRepository: user,)),
                    Screen(title: 'Profile', icon: Icon(CustomIcons.profile), component: ProfilePage(userRepository: user))
                ];
            })
        });

        super.initState();
    }

    Widget _buildBody(int selectedIndex) {
        return _screens[selectedIndex].component;
    }

    @override
    Widget build(BuildContext context) {
        if (_screens != null) {
            return Scaffold(
                body: _buildBody(_selectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                    items: _screens.map((screen) {
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
        else return Scaffold(
            backgroundColor: Colors.red,
        );
    }
}
