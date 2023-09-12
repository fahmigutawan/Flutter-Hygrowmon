import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> configureDependencies() async {
  locator.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  locator.registerSingletonWithDependencies(
    () => Repository(),
    dependsOn: [
      SharedPreferences,
    ],
  );
}
