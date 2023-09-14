import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/data/repository/repository.dart';
import 'package:flutter_hygrowmon/di/injection.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final repo = locator.get<Repository>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}