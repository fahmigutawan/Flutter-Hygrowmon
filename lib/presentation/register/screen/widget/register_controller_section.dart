import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/presentation/register/controller/register_controller.dart';

import '../../../../helper/snackbar_manager.dart';
import '../../../../theme_data/AppColor.dart';
import '../../../../theme_data/AppDecoration.dart';

class RegisterControllerSection extends StatefulWidget {
  RegisterController controller;

  RegisterControllerSection({super.key, required this.controller});

  @override
  State<RegisterControllerSection> createState() =>
      _RegisterControllerSectionState(controller);
}

class _RegisterControllerSectionState extends State<RegisterControllerSection> {
  RegisterController controller;

  _RegisterControllerSectionState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        runSpacing: 16,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo!",
                  style: TextStyle(
                    color: AppColor.White,
                    fontSize: 36,
                  ),
                ),
                Text(
                  "Silahkan isi form di bawah untuk daftar",
                  style: TextStyle(
                    color: AppColor.White,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: controller.nameController,
            cursorColor: AppColor.White,
            decoration: AppDecoration.outlinedTextFieldInverted
                .copyWith(labelText: "Nama Lengkap"),
            style: TextStyle(color: AppColor.White),
          ),
          DropdownButtonFormField(
            items: ["Petani", "Pembeli"]
                .map(
                  (String e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (s) {
              controller.roleController.text = s!;
            },
            dropdownColor: Colors.blueGrey,
            iconEnabledColor: AppColor.White,
            decoration: AppDecoration.outlinedDropdownInverted
                .copyWith(labelText: "Daftar Sebagai"),
            style: TextStyle(color: AppColor.White),
          ),
          TextField(
            controller: controller.noTelpController,
            cursorColor: AppColor.White,
            decoration: AppDecoration.outlinedTextFieldInverted
                .copyWith(labelText: "No Telepon"),
            style: TextStyle(color: AppColor.White),
          ),
          TextField(
            controller: controller.emailController,
            cursorColor: AppColor.White,
            decoration: AppDecoration.outlinedTextFieldInverted
                .copyWith(labelText: "Email"),
            style: TextStyle(color: AppColor.White),
          ),
          TextField(
            controller: controller.passwordController,
            cursorColor: AppColor.White,
            decoration: AppDecoration.outlinedTextFieldInverted
                .copyWith(labelText: "Password"),
            style: TextStyle(color: AppColor.White),
            obscureText: true,
          ),
          TextField(
            controller: controller.rePasswordController,
            cursorColor: AppColor.White,
            decoration: AppDecoration.outlinedTextFieldInverted
                .copyWith(labelText: "Ulangi Password"),
            style: TextStyle(color: AppColor.White),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.isValidData()) {
                if (controller.noTelpError().isNotEmpty) {
                  SnackbarManager.showSnackbarNormal(
                    controller.noTelpError(),
                    context,
                  );
                  return;
                }

                if(controller.passwordNotMatchError().isNotEmpty){
                  SnackbarManager.showSnackbarNormal(
                    controller.passwordNotMatchError(),
                    context,
                  );
                  return;
                }

                //Call register function EXACTLY here
              } else {
                SnackbarManager.showSnackbarNormal(
                  "Masukkan data dengan benar",
                  context,
                );
              }
            },
            child: Text("Daftar"),
          )
        ],
      ),
    );
  }
}
