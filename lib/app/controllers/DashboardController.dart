import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../config/app_config.dart';
import '../data/repository/http/incidentFormsRepository.dart';

class DashboardController extends GetxController{
  static DashboardController get to => Get.put(DashboardController());
TextEditingController search =TextEditingController();

  TextEditingController searchController = TextEditingController();
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
  final _getListList=[].obs;

  get getListList => _getListList.value;

  set getListList(value) {
    _getListList.value = value;
  }
  final _getListLoading=false.obs;

  get getListLoading => _getListLoading.value;

  set getListLoading(value) {
    _getListLoading.value = value;
  }
  final _getListEmpty=false.obs;

  get getListEmpty => _getListEmpty.value;

  set getListEmpty(value) {
    _getListEmpty.value = value;
  }
  final repository=IncidentFormRepository();



}