import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
    AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
    @override
    String toString() => 'AppStarted';
}

class AuthenticationCodeSent extends AuthenticationEvent {
    final String verificationId;

    AuthenticationCodeSent({ @required this.verificationId }) : super([verificationId]);

    @override
    String toString() => 'AppStarted';
}

class AuthenticationPhoneVerificationCompleted extends AuthenticationEvent {
    final FirebaseUser user;

    AuthenticationPhoneVerificationCompleted({ @required this.user }) : super([user]);

    @override
    String toString() => 'AppStarted';
}

class SmsCodeSubmitted extends AuthenticationEvent {
    final String smsCode;
    SmsCodeSubmitted({ @required this.smsCode }) : super([smsCode]);

    @override
    String toString() => 'Sms Code Submitted';
}

class LoggedIn extends AuthenticationEvent {
    final String token;

    LoggedIn({@required this.token}) : super([token]);

    @override
    String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {
    @override
    String toString() => 'LoggedOut';
}