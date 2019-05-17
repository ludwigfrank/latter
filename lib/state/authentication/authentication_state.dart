import 'package:equatable/equatable.dart';

enum AuthenticationStates {
    // if the authentication state was uninitialized, the user might be seeing a splash screen.
    UNINITIALIZED,
    // if the authentication state was loading, the user might be seeing a progress indicator.
    LOADING,
    // if the authentication state was authenticated, the user might see a home screen.
    AUTHENTICATED,
    // if the authentication state was unauthenticated, the user might see a login form.
    UNAUTHENTICATED
}

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
    @override
    String toString() => 'Authentication: Uninitialized';
}

class AuthenticationUnauthenticated extends AuthenticationState {
    @override
    String toString() => 'Authentication: Unauthenticated';
}

class AuthenticationAuthenticated extends AuthenticationState {
    @override
    String toString() => 'Authentication: Authenticated';
}

class AuthenticationLoading extends AuthenticationState {
    @override
    String toString() => 'Authentication: Loading';
}