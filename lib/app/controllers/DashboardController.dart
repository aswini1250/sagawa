import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../config/app_config.dart';

class DashboardController extends GetxController{
  static DashboardController get to => Get.put(DashboardController());
TextEditingController search =TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController IncidentCategories = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController divisorCostCentre = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController creatorName = TextEditingController();
  TextEditingController placeOfOccurance = TextEditingController();
  TextEditingController dateAndTime = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController staffId = TextEditingController();
  TextEditingController sghVehicleNumber = TextEditingController();
  TextEditingController consigneeShipper = TextEditingController();
  TextEditingController mawb = TextEditingController();
  TextEditingController hawb = TextEditingController();
  TextEditingController totalQuantityOfItem = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController quantityOfDamaged = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController correctionAction = TextEditingController();
  TextEditingController preventiveAction = TextEditingController();
  TextEditingController rootCauseAnalysis = TextEditingController();

  init() {
    Future.delayed(Duration(seconds: 0),(){

    });
    debounce(_searchValue, (value) async {
      debugPrint("entry of search controlle");
      debugPrint('*******************************');

    //  getAllListDetails();
    },
        time:AppConfig.debounceDuration);
  }
  final _searchValue ="".obs;

  get searchValue => _searchValue.value;

  set searchValue(value) {
    _searchValue.value = value;
  }
  final _choosenValue="".obs;

  get choosenValue => _choosenValue.value;

  set choosenValue(value) {
    _choosenValue.value = value;
  }
}