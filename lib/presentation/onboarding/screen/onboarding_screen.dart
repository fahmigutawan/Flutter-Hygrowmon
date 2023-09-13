import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/presentation/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_hygrowmon/presentation/onboarding/screen/widget/onboarding_titledescription.dart';
import 'package:flutter_hygrowmon/router/routes.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingController controller = Get.find();
  final pageController = PageController(initialPage: 0);

  List<OnboardingData> datas = [
    OnboardingData(
        "Belanja produk pertanian dengan mudah dan cepat",
        "Temukan ribuan produk pertanian mulai dari peralatan hingga benih dengan harga yang bersaing",
        "assets/images/onboarding_1.png"),
    OnboardingData(
        "Ketahui status terkini lahan pertanian padi milikmu",
        "Dapatkan terus update informasi tanaman padi milikmu melalui alat yuang terpasang!. Tak perlu khawatir tanaman tidak terawat",
        "assets/images/onboarding_2.png"),
    OnboardingData(
        "Konsultasikan perawatan tanamanmu dengan mudah",
        "Ketahui beberapa informasi penting terkait dengan perawatan tanaman pertanian berkonsep smart farming",
        "assets/images/onboarding_3.png")
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) => WillPopScope(
        child: Scaffold(
          backgroundColor: AppColor.Green,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  OnboardingTitleDescription(
                    datas[index].title,
                    datas[index].description,
                    index,
                    datas.length,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 64, right: 64, top: 64),
                    child: Image.asset(datas[index].imgRef),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          if (index < (datas.length - 1)) {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          } else {
                            controller.setFirstTimeState();
                            if (controller.isLogin()) {
                              context.pushReplacement(Routes.Dashboard);
                            } else {
                              context.pushReplacement(Routes.Login);
                            }
                          }
                        },
                        child: Text((index == (datas.length - 1))
                            ? "Lewati"
                            : "Selanjutnya"),
                      ),
                      width: double.infinity,
                    ),
                    (index < (datas.length - 1))
                        ? TextButton(
                            onPressed: () {
                              controller.setFirstTimeState();
                              if (controller.isLogin()) {
                                context.pushReplacement(Routes.Dashboard);
                              } else {
                                context.pushReplacement(Routes.Login);
                              }
                            },
                            child: Text(
                              "Lewati",
                              style: TextStyle(color: AppColor.White),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          if (index == 0) return true;

          pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          return false;
        },
      ),
      itemCount: datas.length,
    );
  }
}
