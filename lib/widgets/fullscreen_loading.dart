import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme_data/AppColor.dart';

class FullscreenLoadingBox extends StatelessWidget {
  const FullscreenLoadingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: SpinKitFoldingCube(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? AppColor.LightBrown : AppColor.DarkBrown,
            ),
          );
        },
        duration: Duration(milliseconds: 1800),
      ),
    );
  }
}
