import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum WebScreenType {
  Mobile,
  Tab,
  Window,
}



responsiveScreen({required BuildContext context}){
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    if (screenWidth < 600) {
      // Mobile screen
      return WebScreenType.Mobile;
    } else if (screenWidth < 900) {
      // Tablet screen
      return WebScreenType.Tab;
    } else {
      // Larger screen (desktop)
      return WebScreenType.Window;
    }
}

