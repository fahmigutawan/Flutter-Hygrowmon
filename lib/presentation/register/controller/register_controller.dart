import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/helper/validator.dart';
import 'package:flutter_hygrowmon/table_struct/role.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  List<RoleStruct> roles = [];

  bool isValidData() {
    if (nameController.text.isEmpty) return false;
    if (roleIdController.text.isEmpty) return false;
    if (noTelpController.text.isEmpty) return false;
    if (!emailController.text.isCorrectEmailFormat()) return false;
    if (!passwordController.text.isAllowedPassword()) return false;
    return true;
  }

  String noTelpError() {
    if (!noTelpController.text.isPhoneNumber)
      return "Masukkan nomor telepon dengan benar";
    return "";
  }

  String passwordNotMatchError(){
    if(passwordController.text != rePasswordController.text)
      return "Password dan Konfirmasi Password harus sama";
    return "";
  }
}
