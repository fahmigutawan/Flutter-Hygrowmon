import 'package:flutter_hygrowmon/data/services/shared_preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  late SharedPreferencesServices sharedPref;

  Repository(SharedPreferencesServices sharedPref){
    this.sharedPref = sharedPref;
  }
}
