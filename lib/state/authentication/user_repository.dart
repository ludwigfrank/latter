import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserRepository {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    FirebaseUser instanceUser;

    final FlutterSecureStorage storage = FlutterSecureStorage();

    get verificationId => storage.read(key: 'verificationId');
    get idToken => storage.read(key: 'idToken');
    get currentUser => _auth.currentUser();

    Future<Null> verifyPhoneNumber({
        @required String phoneNumber,
        @required Function codeSent,
        @required Function codeAutoRetrievalTimeout,
        @required Function verificationCompleted,
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
            verificationCompleted: verificationCompleted,

            ///   Triggered when an error occurred during phone number verification.
            verificationFailed: verificationFailed
        );

        return null;
    }

    Future<void> signInWithPhoneNumber({
        // the verificationID returned from codeSent
        @required verificationId,
        // the sms code send to the user number
        @required smsCode,
        Function confirmationCallback,
        Function errorCallback
    }) async {
        final errorMessage = "We couldn't verify your code, please try again!";

        final AuthCredential credential = PhoneAuthProvider.getCredential(
            verificationId: verificationId,
            smsCode: smsCode,
        );

        print(credential);

        final FirebaseUser user = await _auth.signInWithCredential(credential);
        instanceUser = user;

        String token = await user.getIdToken();
        String uid = user.uid;

        persistToken(token);
        persistUID(uid);

        print(token);
    }

    Future<String> authenticate({
        @required String username,
        @required String password,
    }) async {
        await Future.delayed(Duration(seconds: 1));
        return 'token';
    }

    Future<void> deleteToken() async {
        /// delete from keystore/keychain
        await Future.delayed(Duration(seconds: 1));
        return;
    }

    Future<void> persistVerificationId(String verificationId) async {
        /// write to keystore/keychain
        await storage.write(key: 'verificationId', value: verificationId);
        return;
    }

    Future<void> persistToken(String token) async {
        /// write to keystore/keychain
        await storage.write(key: 'idToken', value: token);
        return;
    }

    Future<void> persistUID(String uid) async {
        /// write to keystore/keychain
        await storage.write(key: 'uid', value: uid);
        return;
    }

    Future<bool> hasToken() async {
        /// read from keystore/keychain
        ///
        String idToken = await this.idToken;
        print(idToken);
        if (idToken != null) return true;

        return false;
    }
}