import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/helper/snackbar_manager.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_hygrowmon/presentation/login/bloc/login_state.dart';
import 'package:flutter_hygrowmon/presentation/login/controller/login_controller.dart';
import 'package:flutter_hygrowmon/presentation/login/screen/widget/login_controller_section.dart';
import 'package:flutter_hygrowmon/theme_data/AppDecoration.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../../theme_data/AppColor.dart';
import '../../../widgets/fullscreen_loading.dart';
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
      resizeToAvoidBottomInset: false,
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

                  if (state is LoginSuccess) {
                    SnackbarManager.showSnackbarNormal(
                      "Berhasil login sebagai ${state.user.email}",
                      context,
                    );

                    // context.pushReplacement(Routes.Dashboard) USE THIS INSTEAD IF BEEN READY
                    context.go(Routes.Monitoring);
                  }
                },
                child: Container(
                  color: AppColor.Green,
                  child: SingleChildScrollView(
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
                            LoginControllerSection(controller: controller),
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
              ),
              if (state is LoginLoading) FullscreenLoadingBox(),
            ],
          ),
        ),
      ),
    );
  }
}
