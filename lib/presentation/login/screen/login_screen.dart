import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/helper/snackbar_manager.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_state.dart';
import 'package:flutter_hygrowmon/presentation/login/controller/login_controller.dart';
import 'package:flutter_hygrowmon/theme_data/AppDecoration.dart';
import 'package:flutter_hygrowmon/widgets/fullscreen_loading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../router/routes.dart';
import '../../../theme_data/AppColor.dart';
import '../bloc/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginInitial()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => Stack(
            children: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginError) {
                    SnackbarManager.showSnackbarNormal(
                      state.errMessage,
                      context,
                    );
                  }

                  if(state is LoginSuccess){
                    SnackbarManager.showSnackbarNormal(
                      "Berhasil login sebagai ${state.user.email}",
                      context,
                    );

                    context.go(Routes.Dashboard);
                  }
                },
                child: Container(
                  color: AppColor.Green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 84),
                              child: Text(
                                "Agrisolute",
                                style: TextStyle(
                                  fontSize: 34,
                                  color: AppColor.White,
                                  fontFamily: "Crete Round Regular",
                                ),
                              ),
                            ),
                          ),
                          Padding(
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
                                  style: TextStyle(color: AppColor.White),
                                ),
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
                                    context.read<LoginBloc>().add(StartLogin(
                                          controller.emailController.text,
                                          controller.passwordController.text,
                                        ));
                                  },
                                  child: Text("Masuk"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 48),
                        child: Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Belum memiliki akun?",
                              style: TextStyle(color: AppColor.White),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(Routes.Register);
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColor.LightBrown),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (state is LoginLoading) FullscreenLoadingBox(),
            ],
          ),
        ),
      ),
    );
  }
}
