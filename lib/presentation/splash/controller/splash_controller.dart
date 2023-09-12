import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final Repository repo = locator.get<Repository>();

  bool isLogin(){
    return repo.isLogin();
  }

  bool isFirstTime(){
    return repo.getFirstTimeState();
  }
}
