import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latter/state/login/login.dart';
import 'package:latter/styles/text.dart';
import 'package:latter/styles/input.dart';

class LoginSmsVerificationForm extends StatefulWidget {
    final LoginBloc loginBloc;

    LoginSmsVerificationForm({
        Key key,
        @required this.loginBloc,
    }) : super(key: key);

    @override
    State<LoginSmsVerificationForm> createState() => _LoginSmsVerificationFormState();
}

class _LoginSmsVerificationFormState extends State<LoginSmsVerificationForm> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _smsCode = '';

    LoginBloc get _loginBloc => widget.loginBloc;

    Widget _buildDescription() {
        return Column(
            children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                        'SMS Code',
                        style: header2TextStyle,
                        textAlign: TextAlign.center,
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Text(
                        'Please enter the 6 digit code that was send to you.',
                        style: body2TextStyle,
                        textAlign: TextAlign.center,
                    ),
                )
            ],
        );
    }

    Widget _buildSmsVerificationInput({String hintText}) {
        return TextFormField(
            style: inputTextStyle,
            keyboardType: TextInputType.phone,
            initialValue: hintText,
            onSaved: (String value) => _smsCode = value,
            decoration: defaultTextInputDecoration.copyWith(hintText: hintText),
        );
    }


    Widget _buildSubmitButton() {
        return OutlineButton(
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Text('Submit SMS Code', style: buttonTextStyle),
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
                                child: _buildSmsVerificationInput(hintText: '000000')
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
        _loginBloc.dispatch(SmsCodeSubmitButtonPressed(
            smsCode: '$_smsCode',
        ));
    }
}
