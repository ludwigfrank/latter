import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:latter/core/models/profile.dart';
import 'package:latter/core/models/serializers.dart';
import 'package:latter/core/services/authentication_service.dart';

class ProfileService {
    final Firestore _db = Firestore.instance;
    final AuthenticationService _authenticationService;

    ProfileService({ AuthenticationService authenticationService }) : _authenticationService = authenticationService;

    Stream<FirebaseUser> get user => _authenticationService.user;

    Future<Profile> futureProfile() async {
        CollectionReference profiles = _db.collection('profiles');
        DocumentSnapshot snapshot;

        FirebaseUser _user = await user.first;

        await profiles.document(_user.uid).get()
            .then((doc) {
                if (!doc.exists) {

                    Profile newProfile = Profile((b) => b
                        ..displayName = _user.displayName
                        ..phoneNumber = _user.phoneNumber
                        ..id = _user.uid
                        ..contacts = null
                        ..conversations = null
                    );

                    profiles.document(_user.uid)
                        .setData(standardSerializers.serializeWith(Profile.serializer, newProfile));

                } else {
                    snapshot = doc;
                }
            })
            .catchError((error) => print(error));

        return standardSerializers.deserializeWith(Profile.serializer, snapshot);
    }

    Stream<Profile> streamProfile() async* {
        CollectionReference profiles = _db.collection('profiles');

        FirebaseUser _user = await user.first;

        yield* profiles
            .document(_user.uid)
            .snapshots()
            .map((DocumentSnapshot snapshot) {
            print(snapshot.data);
            return standardSerializers.deserializeWith(Profile.serializer, snapshot.data);
        });
    }

    Future<Profile> getProfileFromPhoneNumber(String phoneNumber) async {
        CollectionReference profiles = _db.collection('profiles');

        try {
            QuerySnapshot profileSnapshot = await profiles
                .where('phoneNumber', isEqualTo: phoneNumber)
                .getDocuments();

            print(profileSnapshot.documents[0].data);

            Profile profile = standardSerializers.deserializeWith(Profile.serializer, profileSnapshot.documents[0].data);

            return profile;
        } catch (error) {
            print(error);
            return null;
        }
    }
    
    void addContact(Profile profile) async {
        CollectionReference profiles = _db.collection('profiles');

        try {
            FirebaseUser _user = await user.first;

            Map serializedContact = standardSerializers.serializeWith(Profile.serializer, profile);

            profiles
                .document(_user.uid)
                .collection('contacts')
                .document(profile.id)
                .setData(serializedContact);

        } catch (error) {
            print(error);
        }
    }
}