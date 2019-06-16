import 'package:get_it/get_it.dart';
import 'package:latter/core/services/authentication_service.dart';
import 'package:latter/core/services/profile_service.dart';

GetIt locator = GetIt();

void setupLocator() {
    locator.registerLazySingleton(() => AuthenticationService());
}