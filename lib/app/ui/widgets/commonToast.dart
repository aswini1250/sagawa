

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonToast {
  static show({String? msg}){
    return Fluttertoast.showToast(
      msg: "$msg",
      webShowClose: true,
      backgroundColor: Colors.black,
      timeInSecForIosWeb: 5,
      webBgColor: "linear-gradient(#334, #000)",
      webPosition: "center",// message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.CENTER, // location
    );
  }
}