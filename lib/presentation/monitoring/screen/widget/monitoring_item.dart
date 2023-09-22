import 'package:flutter/material.dart';
import 'package:flutter_hygrowmon/theme_data/AppColor.dart';

class MonitoringItem extends StatelessWidget {
  String img;
  String data;
  String label;

  MonitoringItem(
      {super.key, required this.img, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.White,
      shadowColor: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              this.img,
              height: 48,
              fit: BoxFit.contain,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this.label,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(this.data),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
