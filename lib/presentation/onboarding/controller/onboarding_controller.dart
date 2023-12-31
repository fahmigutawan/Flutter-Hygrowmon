import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  final repo = locator.get<Repository>();

  void setFirstTimeState(){
    repo.saveFirstTimeState(false);
  }

  bool isLogin() => repo.isLogin();
}