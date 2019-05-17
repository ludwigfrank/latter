import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
    LoginEvent([List props = const []]) : super(props);
}

class PhoneNumberSubmitButtonPressed extends LoginEvent {
    final String phoneNumber;

    PhoneNumberSubmitButtonPressed({ @required this.phoneNumber }) : super([ phoneNumber ]);

    @override
    String toString() => 'Phone number submitted: $phoneNumber';
}

class SmsCodeSubmitButtonPressed extends LoginEvent {
    final String smsCode;

    SmsCodeSubmitButtonPressed({ @required this.smsCode }) : super([ smsCode ]);

    @override
    String toString() => 'SMS verification code submitted: $smsCode';
}