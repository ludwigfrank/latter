import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latter/pages/profile/profile.dart';
import 'package:latter/styles/input.dart';
import 'package:latter/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
    final FirebaseUser _userRepository;

    ProfilePage({Key key, @required FirebaseUser userRepository})
        : assert(userRepository != null), _userRepository = userRepository, super(key: key);

    static String title = 'Profile';

    @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    ProfileBloc _profileBloc;

    final FocusNode _nameInputFocus = FocusNode();
    final _nameInputController = TextEditingController(text: 'Ludwig Frank');

    final FocusNode _aboutInputFocus = FocusNode();
    final _aboutInputController = TextEditingController(text: "Hey! I'm using Latter.");

    FirebaseUser get _userRepository => widget._userRepository;

    @override
    void initState() {
        super.initState();

        _nameInputFocus.addListener(_onInputFocusChange);
    }

    void _onInputFocusChange() {
        debugPrint("Focus: " + _nameInputFocus.hasFocus.toString());
    }

    Widget _buildInput({String title}) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text(title, style: body2TextStyle, textAlign: TextAlign.left,),
                TextFormField(
                    style: inputTextStyle2,
                    focusNode: _nameInputFocus,
                    controller: _nameInputController,
                    keyboardType: TextInputType.text,
                    decoration: defaultTextInputDecoration.copyWith(
                        filled: false,
                        contentPadding: EdgeInsets.only(top: 8.0, bottom: 12.0)
                    ),
                ),
                /* OutlineButton(
                    onPressed: () {
                        Firestore.instance.collection('users').document(_userRepository.uid).setData({'name': _nameInputController.text});
                    },
                    child: Text('Press Me'),
                ) */
            ],
        );
    }

    Widget _buildPhoneInput({String initialValue}) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text('Phone Number', style: body2TextStyle, textAlign: TextAlign.left,),
                TextFormField(
                    style: inputTextStyle2,
                    initialValue: initialValue,
                    decoration: defaultTextInputDecoration.copyWith(
                        filled: false,
                        contentPadding: EdgeInsets.only(top: 8.0, bottom: 12.0)
                    ),
                ),
            ],
        );
    }

    Widget _buildAboutInput() {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text('About', style: body2TextStyle, textAlign: TextAlign.left,),
                TextFormField(
                    style: inputTextStyle2,
                    focusNode: _aboutInputFocus,
                    controller: _aboutInputController,
                    decoration: defaultTextInputDecoration.copyWith(
                        filled: false,
                        contentPadding: EdgeInsets.only(top: 8.0, bottom: 12.0)
                    ),
                ),
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                ProfileAppbar(),
                Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                        children: <Widget>[
                            _buildInput(title: 'Name'),
                            SizedBox(height: 24.0,),
                            _buildAboutInput(),
                            SizedBox(height: 24.0,),
                            _buildPhoneInput(initialValue: _userRepository.phoneNumber)
                        ],
                    ),
                ),
            ],
        );
    }

    @override
    void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _nameInputController.dispose();
        super.dispose();
    }
}




