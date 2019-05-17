import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:latter/pages/home/home.dart';
import 'package:latter/pages/login/login.dart';
import 'package:latter/pages/permissions/permissions_widget.dart';
import 'package:latter/state/authentication/authentication.dart';
import 'package:latter/helpers/simple_bloc_delegate.dart';


main() {
    BlocSupervisor().delegate = SimpleBlocDelegate();
    runApp(App());
}

class App extends StatefulWidget {
    State<App> createState() => _AppState();
}

class _AppState extends State<App> {
    final UserRepository _userRepository = UserRepository();
    AuthenticationBloc _authenticationBloc;
    bool _permissionsGranted = false;

    @override
    void initState() {
        super.initState();
        _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
        _authenticationBloc.dispatch(AppStarted());
        logUser();
    }

    void logUser() async {
        FirebaseUser user = await _userRepository.currentUser;
        print(user);
    }

    @override
    Widget build(BuildContext context) {
        return BlocProvider(
            bloc: _authenticationBloc,
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: BlocBuilder(
                    bloc: _authenticationBloc,
                    builder: (BuildContext context, AuthenticationState state) {
                        if (state is AuthenticationUninitialized) {
                            return Scaffold(
                                body: Center(
                                    child: Text('Loading'),
                                ),
                            );
                        }

                        if (state is AuthenticationUnauthenticated || state is AuthenticationLoading) {
                            return LoginPage(userRepository: _userRepository,);
                        }

                        // TODO: Permission State
                        if (state is AuthenticationAuthenticated && !_permissionsGranted) {
                            return PermissionsPage();
                        }

                        if (state is AuthenticationAuthenticated) {
                            return HomePage(userRepository: _userRepository,);
                        }

                        return Scaffold(
                            body: Center(
                                child: Text('Loading'),
                            ),
                        );

                        /*
                        if (state is Unauthenticated) {
                            return LoginScreen(userRepository: _userRepository);
                        }

                        if (state is Authenticated) {
                            return HomeScreen(name: state.displayName);
                        } */
                    },
                ),
            ),
        );
    }

    @override
    void dispose() {
        _authenticationBloc.dispose();
        super.dispose();
    }
}