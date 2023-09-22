import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';
import 'package:marquee/marquee.dart';

class MonitoringItem extends StatelessWidget {
  String img;
  String data;
  String label;
  double width;

  MonitoringItem(
      {super.key,
      required this.img,
      required this.data,
      required this.label,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.White,
      shadowColor: Colors.black,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Image.asset(
              this.img,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  this.data,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
