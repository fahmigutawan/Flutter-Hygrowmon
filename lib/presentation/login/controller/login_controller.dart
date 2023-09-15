import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:flutter_hygrowmon/helper/validator.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidData(){
    if(!emailController.text.isCorrectEmailFormat()) return false;
    if(!passwordController.text.isAllowedPassword()) return false;
    return true;
  }
}