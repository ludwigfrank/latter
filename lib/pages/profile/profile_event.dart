import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
    ProfileEvent([List props = const []]) : super(props);
}

class UsernameChanged extends ProfileEvent {
    final String username;

    UsernameChanged({@required this.username}) : super([username]);

    @override
    String toString() => 'PROFILE: Username changed to { username :$username }';
}
