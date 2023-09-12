import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/injection.dart';

class Repository {
  final SharedPreferences pref = locator.get<SharedPreferences>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLogin(){
    return auth.currentUser != null;
  }

  void saveFirstTimeState(bool state){
    pref.setBool("first_time", state);
  }

  bool getFirstTimeState(){
    return pref.getBool("first_time") ?? true;
  }
}
