import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/MyColors.dart';

class CommonClearButton extends StatelessWidget {
  const CommonClearButton(

      {Key? key, required this.onTapped}) : super(key: key);
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child:   InkWell(
          onTap: onTapped,
          child: Container(
            height: 30,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Clear",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
