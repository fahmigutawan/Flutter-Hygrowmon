import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/data/services/shared_preferences_services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class Module {
  @preResolve
  Future<SharedPreferences> provideSharedPreferences() async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  SharedPreferencesServices provideSharedPreferencesServices(SharedPreferences pref) =>
      SharedPreferencesServices(pref);

  @lazySingleton
  Repository provideRepository(SharedPreferencesServices sharedPref) =>
      Repository(sharedPref);
}
