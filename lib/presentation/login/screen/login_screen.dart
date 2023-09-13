import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/theme_data/AppDecoration.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../../theme_data/AppColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        controller: emailController,
                        cursorColor: AppColor.White,
                        decoration: AppDecoration.outlinedTextFieldInverted
                            .copyWith(labelText: "Email"),
                        style: TextStyle(color: AppColor.White),
                      ),
                      TextField(
                        controller: passwordController,
                        cursorColor: AppColor.White,
                        decoration: AppDecoration.outlinedTextFieldInverted
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
                      ElevatedButton(onPressed: () {}, child: Text("Masuk"))
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
    );
  }
}
