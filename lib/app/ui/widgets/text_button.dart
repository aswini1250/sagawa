//Packages
import 'package:flutter/material.dart';

import '../themes/MyColors.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {Key? key,
        this.text,
        required this.ontap,
        this.color,
        this.fontWeight=FontWeight.normal,
        this.size = 15.0})
      : super(key: key);

  final String? text;
  final Function()? ontap;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextButton(
        onPressed: ontap,
        child: Text(
          text!,
          style: TextStyle(
              fontSize: size,
              color: AppColors.primaryColor,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
