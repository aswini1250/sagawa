

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/ui/widgets/progress_loading.dart';

class CommonScreenLoading{

  static  show({ String? text}){
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          insetPadding: EdgeInsets.zero,
          child:Stack(
            children: [
              Opacity(
                opacity: 0.2,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProgressLoading(
                        color: Colors.white,
                      ),
                      SizedBox(height: 15,),
                      Text("${text??""}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),)
                    ],
                  )),
            ],
          ) ,
        );
      },
    );
  }






}