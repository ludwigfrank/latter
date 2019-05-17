import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:latter/state/authentication/authentication_bloc.dart';
import 'package:latter/state/authentication/authentication_event.dart';
import 'package:latter/state/authentication/user_repository.dart';
import 'package:latter/state/login/login_event.dart';
import 'package:latter/state/login/login_state.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
    final UserRepository userRepository;
    final AuthenticationBloc authenticationBloc;

    LoginBloc({
        @required this.userRepository,
        @required this.authenticationBloc,
    })  : assert(userRepository != null),
            assert(authenticationBloc != null);

    LoginState get initialState => LoginInitial();

    @override
    Stream<LoginState> mapEventToState(LoginEvent event) async* {
        if (event is PhoneNumberSubmitButtonPressed) {
            try {
                await userRepository.verifyPhoneNumber(
                    phoneNumber: event.phoneNumber,

                    codeSent: (String verificationId, [int forceResendingToken]) {
                        print('Authentication Code sent $verificationId');
                        authenticationBloc.dispatch(AuthenticationCodeSent(verificationId: verificationId));
                    },

                    codeAutoRetrievalTimeout: (String verificationId) =>
                        print('Code Auto Retrieval Timeout: $verificationId'),

                    verificationCompleted: (FirebaseUser user) =>
                        authenticationBloc.dispatch(AuthenticationPhoneVerificationCompleted(user: user)),

                    verificationFailed: null
                );
                yield LoginSmsVerification();
            } catch (error) {
                print('Login Failure');
                yield LoginFailure(error: error.toString());
            }
        }

        if (event is SmsCodeSubmitButtonPressed) {
            String smsCode = event.smsCode;
            print('sms code submitted');
            authenticationBloc.dispatch(SmsCodeSubmitted(
                smsCode: smsCode
            ));
        }
    }
}
