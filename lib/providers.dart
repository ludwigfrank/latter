import 'package:firebase_auth/firebase_auth.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/conversation_service.dart';
import 'package:provider/provider.dart';

import 'package:latter/core/services/profile_service.dart';
import 'package:latter/core/services/authentication_service.dart';
import 'package:latter/core/services/interval_service.dart';
import 'package:latter/core/services/shared_preferences_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider<AuthenticationService>(
    builder: (context) => AuthenticationService(),
  ),
  Provider<ConversationService>(
    builder: (context) => ConversationService(),
  ),
  Provider<IntervalService>(
    builder: (context) => IntervalService(),
  ),
  Provider<SharedPreferencesService>(
    builder: (context) => SharedPreferencesService(),
  )
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<AuthenticationService, ProfileService>(
    builder: (context, authenticationService, profileService) => ProfileService(authenticationService: authenticationService),
  ),
  ProxyProvider<SharedPreferencesService, IntervalService>(
    builder: (context, sharedPreferencesService, intervalService) => IntervalService(sharedPreferencesService: sharedPreferencesService),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<FirebaseUser>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  ),
  StreamProvider<UpdateInterval>(
    builder: (context) => Provider.of<IntervalService>(context, listen: false).streamMessageUpdateInterval(),
  ),
];