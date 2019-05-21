import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthenticationState {
    // if the authentication state was uninitialized, the user might be seeing a splash screen.
    Uninitialized,
    // if the authentication state was unauthenticated, the user might see a login form.
    Unauthenticated,
    // if the phone number was submitted, the user might see the code verification screen
    PhoneNumberSubmitted,
    // if the phone number was submitted, the user might see the code verification screen
    SMSCodeSent,
    // if the authentication state was loading, the user might be seeing a progress indicator.
    Loading,
    // if the authentication state was authenticated, the user might see a home screen.
    Authenticated,
}

class UserRepository with ChangeNotifier {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FlutterSecureStorage storage = FlutterSecureStorage();
    FirebaseAuth _auth = FirebaseAuth.instance;
    AuthenticationState _state = AuthenticationState.Uninitialized;
    FirebaseUser instanceUser;

    UserRepository.instance() : _auth = FirebaseAuth.instance {
        _auth.onAuthStateChanged.listen(_onAuthStateChanged);
    }

    Future<String> get verificationId => storage.read(key: 'verificationId');
    Future<String> get idToken => storage.read(key: 'idToken');
    Future<FirebaseUser> get currentUser => _auth.currentUser();
    AuthenticationState get state => _state;

    void setState(AuthenticationState authenticationState) {
        _state = authenticationState;
        notifyListeners();
    }

    Future<Null> verifyPhoneNumber({
        @required String phoneNumber,
        @required Function codeAutoRetrievalTimeout,
        @required Function verificationFailed,
        Duration timeOut = const Duration(minutes: 1)
    }) async {
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: timeOut,

            ///   It will trigger when an SMS has been sent to the users phone,
            ///   and will include a [verificationId] and [forceResendingToken].
            codeSent: (String verificationId, [int forceResendingToken]) {
                print('Authentication Code sent $verificationId');
                persistVerificationId(verificationId);

                setState(AuthenticationState.SMSCodeSent);
            },

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
        setState(AuthenticationState.Unauthenticated);
        notifyListeners();
        return Future.delayed(Duration.zero);
    }

    Future<void> signInWithPhoneNumber({
        // the sms code send to the user number
        @required smsCode,
        Function confirmationCallback,
        Function errorCallback
    }) async {
        final errorMessage = "We couldn't verify your code, please try again!";

        final _verificationId = await verificationId;

        final AuthCredential credential = PhoneAuthProvider.getCredential(
            verificationId: _verificationId,
            smsCode: smsCode,
        );

        print(credential);

        _auth.signInWithCredential(credential).then((user) async {
            String token = await user.getIdToken();
            String uid = user.uid;

            persistToken(token);
            persistUID(uid);

            print(token);
        }).catchError((onError) => print(onError));
    }

    Future<String> authenticate({
        @required String username,
        @required String password,
    }) async {
        await Future.delayed(Duration(seconds: 1));
        return 'token';
    }

    Future<void> persistVerificationId(String verificationId) async {
        /// write to keystore/keychain
        await storage.write(key: 'verificationId', value: verificationId);
        return;
    }

    Future<void> deleteToken() async {
        /// delete from keystore/keychain
        await Future.delayed(Duration(seconds: 1));
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
        String idToken = await this.idToken;
        print(idToken);
        if (idToken != null) return true;

        return false;
    }

    Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
        if (firebaseUser == null) {
            setState(AuthenticationState.Unauthenticated);
        } else {
            instanceUser = firebaseUser;
            setState(AuthenticationState.Authenticated);
        }
        notifyListeners();
    }
}