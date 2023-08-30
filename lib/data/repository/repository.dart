import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/injection.dart';

class Repository {
  final SharedPreferences pref = locator.get<SharedPreferences>();
}
