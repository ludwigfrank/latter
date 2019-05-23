import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthenticationService {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FlutterSecureStorage storage = FlutterSecureStorage();
    FirebaseAuth _auth = FirebaseAuth.instance;

    Future<String> get _verificationId => storage.read(key: 'verificationId');
    Future<String> get _idToken => storage.read(key: 'idToken');

    Future<FirebaseUser> get userAsFuture => _auth.currentUser();
    Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

    Future<Null> verifyPhoneNumber({
        @required String phoneNumber,
        @required Function codeSent,
        @required Function codeAutoRetrievalTimeout,
        @required Function verificationFailed,
        Duration timeOut = const Duration(minutes: 1)
    }) async {
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: timeOut,

            ///   It will trigger when an SMS has been sent to the users phone,
            ///   and will include a [verificationId] and [forceResendingToken].
            codeSent: codeSent,

            ///   It will trigger when SMS auto-retrieval times out and provide a
            ///   [verificationId].
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,

            ///   It will trigger when an SMS is auto-retrieved or the phone number has
            ///   been instantly verified. The callback will provide a [FirebaseUser].
            verificationCompleted: (AuthCredential credential) => {

            },

            ///   Triggered when an error occurred during phone number verification.
            verificationFailed: verificationFailed
        );

        return null;
    }

    Future signOut() async {
        _auth.signOut();
        deleteToken();
        deleteUID();
        return Future.delayed(Duration.zero);
    }

    Future<FirebaseUser> signInWithSMSCode({
        // the sms code send to the user number
        @required smsCode,
        Function confirmationCallback,
        Function errorCallback
    }) async {
        final errorMessage = "We couldn't verify your code, please try again!";

        try {
            final verificationId = await _verificationId;

            final AuthCredential credential = PhoneAuthProvider.getCredential(
                verificationId: verificationId,
                smsCode: smsCode,
            );

            print(credential);

            FirebaseUser user = await _auth.signInWithCredential(credential);

            String token = await user.getIdToken();
            String uid = user.uid;

            persistToken(token);
            persistUID(uid);

            return user;

        } catch (error) {
            print(error);
            return(null);
        }
    }

    Future<void> persistVerificationId(String verificationId) async {
        await storage.write(key: 'verificationId', value: verificationId);
        return;
    }

    Future<void> persistToken(String token) async {
        /// write to keystore/keychain
        await storage.write(key: 'idToken', value: token);
        return;
    }

    Future<void> deleteToken() async {
        await storage.delete(key: 'idToken');
        return;
    }

    Future<void> persistUID(String uid) async {
        /// write to keystore/keychain
        await storage.write(key: 'uid', value: uid);
        return;
    }

    Future<void> deleteUID() async {
        /// write to keystore/keychain
        await storage.delete(key: 'uid');
        return;
    }

    Future<bool> hasToken() async {
        /// read from keystore/keychain
        String idToken = await _idToken;
        if (idToken != null) return true;

        return false;
    }
}