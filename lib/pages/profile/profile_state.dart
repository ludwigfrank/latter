
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
    ProfileState([List props = const []]) : super(props);
}

class ProfileInitial extends ProfileState {
    @override
    String toString() => 'LoginInitial';
}

class ProfileEditing extends ProfileState {
    @override
    String toString() => 'LoginLoading';
}

class ProfileEdited extends ProfileState {
    @override
    String toString() => 'LoginLoading';
}