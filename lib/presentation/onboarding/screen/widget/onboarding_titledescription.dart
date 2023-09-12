import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingTitleDescription extends StatelessWidget {
  String title;
  String description;
  int index;
  int totalPage;

  OnboardingTitleDescription(
      this.title, this.description, this.index, this.totalPage);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: AppColor.White,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 64, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: AnimatedSmoothIndicator(
                  activeIndex: index,
                  count: totalPage,
                  effect: ExpandingDotsEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(96)),
    );
  }
}
