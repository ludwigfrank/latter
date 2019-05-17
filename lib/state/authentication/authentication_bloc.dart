import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:latter/state/authentication/user_repository.dart';
import 'package:latter/state/authentication/authentication_event.dart';
import 'package:latter/state/authentication/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
    final UserRepository userRepository;

    AuthenticationBloc({@required this.userRepository}) : assert(userRepository != null);

    @override
    AuthenticationState get initialState => AuthenticationUninitialized();

    @override
    Stream<AuthenticationState> mapEventToState(
        AuthenticationEvent event,
        ) async* {
        if (event is AppStarted) {
            final bool hasToken = await userRepository.hasToken();

            if (hasToken) {
                print('User has token');
                yield AuthenticationAuthenticated();
            } else {
                yield AuthenticationUnauthenticated();
            }
        }

        if (event is AuthenticationCodeSent) {
            await userRepository.persistVerificationId(event.verificationId);
        }

        if (event is SmsCodeSubmitted) {
            String verificationId = await userRepository.verificationId;
            await userRepository.signInWithPhoneNumber(
                verificationId: verificationId,
                smsCode: event.smsCode
            );
            yield AuthenticationAuthenticated();
        }

        if (event is AuthenticationPhoneVerificationCompleted) {
            print(event.user);
        }

        if (event is LoggedIn) {
            yield AuthenticationLoading();
            await userRepository.persistToken(event.token);
            yield AuthenticationAuthenticated();
        }

        if (event is LoggedOut) {
            yield AuthenticationLoading();
            await userRepository.deleteToken();
            yield AuthenticationUnauthenticated();
        }
    }
}
