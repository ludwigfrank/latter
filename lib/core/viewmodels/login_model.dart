import 'package:flutter/widgets.dart';
import 'package:latter/core/services/authentication_service.dart';

import '../../locator.dart';

enum ViewState {
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

class LoginModel extends ChangeNotifier {
    ViewState _state = ViewState.Uninitialized;
    ViewState get state => _state;

    void setState(ViewState viewState) {
        _state = viewState;
        notifyListeners();
    }

    final AuthenticationService _authenticationService = locator<AuthenticationService>();

    Future<Null> verifyPhoneNumber({ phoneNumber }) async {
        await _authenticationService.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            codeSent: () => setState(ViewState.SMSCodeSent),
            codeAutoRetrievalTimeout: null,
            verificationFailed: null
        );

        return null;
    }
}