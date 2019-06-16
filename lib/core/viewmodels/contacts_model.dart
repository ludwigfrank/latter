import 'package:flutter/widgets.dart';

enum ViewState {
    Loading,
    Loaded,
    Selecting
}

class ContactsModel extends ChangeNotifier {
    ViewState _state = ViewState.Loading;
    ViewState get state => _state;

    void setState(ViewState viewState) {
        _state = viewState;
        notifyListeners();
    }

}