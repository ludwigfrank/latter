import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:latter/state/authentication/user_repository.dart';
import 'package:latter/pages/profile/profile_event.dart';
import 'package:latter/pages/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
    UserRepository _userRepository;

    ProfileBloc({
        @required UserRepository userRepository,
    })  : assert(userRepository != null),
            _userRepository = userRepository;

    @override
    ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) {
    // TODO: implement mapEventToState
    return null;
  }

  _mapUserNameChangedToState() async* {
      yield ProfileEdited();


  }
}