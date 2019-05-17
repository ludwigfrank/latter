import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latter/state/login/login.dart';
import 'package:latter/styles/text.dart';
import 'package:latter/styles/input.dart';

class LoginPhoneForm extends StatefulWidget {
    final LoginBloc loginBloc;

    LoginPhoneForm({
        Key key,
        @required this.loginBloc,
    }) : super(key: key);

    @override
    State<LoginPhoneForm> createState() => _LoginPhoneFormState();
}

class _LoginPhoneFormState extends State<LoginPhoneForm> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _phoneCountryCode = '';
    String _phoneNumber = '';

    LoginBloc get _loginBloc => widget.loginBloc;

    Widget _buildDescription() {
        return Column(
            children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        'Your Phone',
                        style: header2TextStyle,
                        textAlign: TextAlign.center,
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Text(
                        'Please confirm the country code and enter your phone number.',
                        style: body2TextStyle,
                        textAlign: TextAlign.center,
                    ),
                )
            ],
        );
    }

    Widget _buildPhoneCountryCodeInput({String hintText}) {
        return TextFormField(
            style: inputTextStyle,
            keyboardType: TextInputType.phone,
            initialValue: hintText,
            onSaved: (String value) => _phoneCountryCode = value,
            decoration: defaultTextInputDecoration.copyWith(hintText: hintText),
        );
    }

    Widget _buildPhoneNumberInput({String hintText}) {
        return TextFormField(
            style: inputTextStyle,
            keyboardType: TextInputType.phone,
            initialValue: hintText,
            onSaved: (String value) => _phoneNumber = value,
            decoration: defaultTextInputDecoration.copyWith(hintText: hintText),
        );
    }

    Widget _buildSubmitButton() {
        return OutlineButton(
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Text('Submit', style: buttonTextStyle),
            onPressed: () {
                _formKey.currentState.save();
                _onSubmitButtonPressed();
            },
        );
    }

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<LoginEvent, LoginState>(
            bloc: _loginBloc,
            builder: (
                BuildContext context,
                LoginState state,
                ) {
                if (state is LoginFailure) {
                    _onWidgetDidBuild(() {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${state.error}'),
                                backgroundColor: Colors.red,
                            ),
                        );
                    });
                }

                return Container(
                    padding: EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: 80
                    ),
                    child: new Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            _buildDescription(),
                            Form(
                                key: _formKey,
                                child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Expanded(
                                            flex: 4,
                                            child: _buildPhoneCountryCodeInput(hintText: '+49')
                                        ),
                                        Spacer(),
                                        Expanded(
                                            flex: 10,
                                            child: _buildPhoneNumberInput(hintText: '1575 3000522')
                                        ),
                                    ],
                                ),
                            ),
                            SizedBox(height: 100.0,),
                            _buildSubmitButton()
                        ],
                    ),
                );
            },
        );
    }

    void _onWidgetDidBuild(Function callback) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            callback();
        });
    }

    _onSubmitButtonPressed() {
        _loginBloc.dispatch(PhoneNumberSubmitButtonPressed(
            phoneNumber: '$_phoneCountryCode$_phoneNumber',
        ));
    }
}
