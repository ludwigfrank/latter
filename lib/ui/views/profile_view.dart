import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/services/profile_service.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
    @override
    _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
    @override
    Widget build(BuildContext context) {
        var profile = ProfileService(user: Provider.of<FirebaseUser>(context));
        print(profile.futureProfile());

        return Container();
    }
}
