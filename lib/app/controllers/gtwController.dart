
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sofproject/app/data/repository/http/PTWRepository.dart';

class GtwController extends  GetxController {

  static GtwController get to => Get.put(GtwController());

  TextEditingController department = TextEditingController();
  TextEditingController selectArea = TextEditingController();
  TextEditingController permitValidTo = TextEditingController();
  TextEditingController JobDescription = TextEditingController();
final repository =PTWRepository();

}