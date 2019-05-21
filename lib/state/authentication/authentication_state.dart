import 'package:equatable/equatable.dart';

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