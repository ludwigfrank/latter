import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
    LoginState([List props = const []]) : super(props);
}

// LoginInitial is the initial state of the LoginForm.
class LoginInitial extends LoginState {
    @override
    String toString() => 'LoginInitial';
}

// LoginLoading is the state of the LoginForm when we are validating credentials
class LoginLoading extends LoginState {
    @override
    String toString() => 'LoginLoading';
}

// LoginSmsVerification is the state after the user received a sms code
class LoginSmsVerification extends LoginState {
    @override
    String toString() => 'LoginSmsVerification';
}

// LoginFailure is the state of the LoginForm when a login attempt has failed.
class LoginFailure extends LoginState {
    final String error;

    LoginFailure({@required this.error}) : super([error]);

    @override
    String toString() => 'LoginFailure { error: $error }';
}