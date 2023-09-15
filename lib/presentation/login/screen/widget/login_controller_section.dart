import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/presentation/login/controller/login_controller.dart';

import '../../../../helper/snackbar_manager.dart';
import '../../../../theme_data/AppColor.dart';
import '../../../../theme_data/AppDecoration.dart';
import '../../bloc/login_bloc.dart';
import '../../bloc/login_event.dart';

class LoginControllerSection extends StatefulWidget {
  LoginController controller;
  LoginControllerSection({super.key, required this.controller});

  @override
  State<LoginControllerSection> createState() => _LoginControllerSectionState(controller);
}

class _LoginControllerSectionState extends State<LoginControllerSection> {
  LoginController controller;
  _LoginControllerSectionState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        runSpacing: 16,
        children: [
          TextField(
              controller: controller.emailController,
              cursorColor: AppColor.White,
              decoration: AppDecoration
                  .outlinedTextFieldInverted
                  .copyWith(labelText: "Email"),
              style: TextStyle(color: AppColor.White)),
          TextField(
            controller: controller.passwordController,
            cursorColor: AppColor.White,
            decoration: AppDecoration
                .outlinedTextFieldInverted
                .copyWith(labelText: "Password"),
            style: TextStyle(color: AppColor.White),
            obscureText: true,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Lupa kata sandi",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColor.LightBrown,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.isValidData()) {
                context.read<LoginBloc>().add(StartLogin(
                  controller.emailController.text,
                  controller.passwordController.text,
                ));
              } else {
                SnackbarManager.showSnackbarNormal(
                  "Masukkan data dengan benar",
                  context,
                );
              }
            },
            child: Text("Masuk"),
          )
        ],
      ),
    );
  }
}
