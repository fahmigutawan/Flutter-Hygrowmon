import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices{
  late SharedPreferences pref;

  SharedPreferencesServices(SharedPreferences pref){
    this.pref = pref;
  }

  void setFirstTimeState(bool state){
    pref.setBool("first_time", state);
  }

  bool getFirstTimeState(){
    return pref.getBool("first_time") ?? true;
  }
}