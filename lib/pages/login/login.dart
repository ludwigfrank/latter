import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latter/state/authentication/authentication.dart';
import 'package:latter/state/login/login.dart';
import 'package:latter/components/login/login_phone_form.dart';
import 'package:latter/components/login/login_sms_verification_form.dart';

class LoginPage extends StatefulWidget {
    final UserRepository _userRepository;

    LoginPage({Key key, @required UserRepository userRepository})
        : assert(userRepository != null), _userRepository = userRepository, super(key: key);

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    LoginBloc _loginBloc;

    UserRepository get _userRepository => widget._userRepository;

    @override
    void initState() {
        super.initState();
        _loginBloc = LoginBloc(
            userRepository: _userRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: BlocProvider<LoginBloc>(
                bloc: _loginBloc,
                child: BlocBuilder(
                    bloc: _loginBloc,
                    builder: (BuildContext context, LoginState state) {
                        if (state is LoginInitial) {
                            return LoginPhoneForm(
                                loginBloc: _loginBloc,
                            );
                        }

                        if (state is LoginSmsVerification) {
                            return LoginSmsVerificationForm(
                                loginBloc: _loginBloc,
                            );
                        }

                        return Text('Check code');
                    },
                )
            ),
        );
    }

    @override
    void dispose() {
        _loginBloc.dispose();
        super.dispose();
    }
}
