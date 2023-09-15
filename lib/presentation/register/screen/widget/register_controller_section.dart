import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_event.dart';
import 'package:flutter_hygrowmon/presentation/register/controller/register_controller.dart';

import '../../../../helper/snackbar_manager.dart';
import '../../../../theme_data/AppColor.dart';
import '../../../../theme_data/AppDecoration.dart';
import '../../bloc/register_state.dart';

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
            items: controller.roles
                .map((e) => DropdownMenuItem(
                      child: Text(e.word),
                      value: e,
                    ))
                .toList(),
            onChanged: (item) {
              controller.roleIdController.text = item?.role_id ?? "";
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

                if (controller.passwordNotMatchError().isNotEmpty) {
                  SnackbarManager.showSnackbarNormal(
                    controller.passwordNotMatchError(),
                    context,
                  );
                  return;
                }

                context.read<RegisterBloc>().add(
                      StartRegister(
                          controller.emailController.text,
                          controller.passwordController.text,
                          controller.nameController.text,
                          controller.noTelpController.text,
                          controller.roleIdController.text),
                    );
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
