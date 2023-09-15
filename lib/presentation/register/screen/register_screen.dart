import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hygrowmon/helper/snackbar_manager.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_event.dart';
import 'package:flutter_hygrowmon/presentation/register/bloc/register_state.dart';
import 'package:flutter_hygrowmon/presentation/register/controller/register_controller.dart';
import 'package:flutter_hygrowmon/presentation/register/screen/widget/register_controller_section.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../../theme_data/AppColor.dart';
import '../../../widgets/fullscreen_loading.dart';
import '../bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterController controller = Get.find<RegisterController>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocProvider<RegisterBloc>(
        create: (context) =>
            RegisterBloc(RegisterInitial())..add(OnRoleDataLoad()),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) => Stack(
            children: [
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RoleSuccess) {
                    controller.roles.addAll(state.data);
                  }

                  if (state is RegisterError) {
                    SnackbarManager.showSnackbarNormal(state.msg, context);
                  }

                  if (state is RegisterSuccess) {
                    SnackbarManager.showSnackbarNormal(
                      "Registrasi berhasil sebagai ${state.data.user?.email}",
                      context,
                    );

                    context.go(Routes.Dashboard);
                  }
                },
                child: Container(
                  color: AppColor.Green,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegisterControllerSection(controller: controller),
                        Padding(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Telah memiliki akun?",
                                style: TextStyle(color: AppColor.White),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push(Routes.Login);
                                },
                                child: Text(
                                  "Masuk",
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
              if (state is Loading) FullscreenLoadingBox(),
            ],
          ),
        ),
      ),
    );
  }
}
