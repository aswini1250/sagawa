
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NotificationController extends GetxController {
  static NotificationController get to =>
      Get.put(NotificationController());
  TextEditingController searchController = TextEditingController();
  final _searchValue ="".obs;

  get searchValue => _searchValue.value;

  set searchValue(value) {
    _searchValue.value = value;
  }


}