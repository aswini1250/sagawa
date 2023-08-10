


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/MyColors.dart';

commonSnackBar({required String title,required String msg}){
  return  Get.snackbar(title,msg,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.secondaryColor.withAlpha(150),
    backgroundGradient: LinearGradient(
        colors: [
          AppColors.primaryColor,
          AppColors.secondaryColor,

        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );

}