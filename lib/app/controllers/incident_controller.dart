import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/ui/widgets/commonToast.dart';
import 'package:sofproject/app/ui/widgets/popup_loading.dart';

import '../config/app_config.dart';
import '../data/repository/http/incidentFormsRepository.dart';

class IncidentController extends GetxController{
  static IncidentController get to => Get.put(IncidentController());
  TextEditingController search =TextEditingController();


  TextEditingController preparedby = TextEditingController();
  TextEditingController status = TextEditingController();

  TextEditingController reportby = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController divisorCostCentre = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController placeOfAccurance = TextEditingController();
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
  TextEditingController correctiveAction = TextEditingController();
  final repository=IncidentFormRepository();

  clearFormField(){
    // incidentCategories.text="";
    preparedby.text="";
    status.text="";
    subject.text="";
    reportby.text="";
    divisorCostCentre.text="";
    customerName.text="";
    placeOfAccurance.text="";
    dateAndTime.text="";
    employeeName.text="";
    staffId.text="";
    sghVehicleNumber.text="";
    consigneeShipper.text="";
    mawb.text="";
    hawb.text="";
    totalQuantityOfItem.text="";
    weight.text="";
    quantityOfDamaged.text="";
    remarks.text="";
    correctiveAction.text="";
    preventiveAction.text="";
    rootCauseAnalysis.text="";
  }



final _viewDropdown=false.obs;

  get viewDropdown => _viewDropdown.value;

  set viewDropdown(value) {
    _viewDropdown.value = value;
  }

  final _dashboardLoading=false.obs;

  get dashboardLoading => _dashboardLoading.value;

  set dashboardLoading(value) {
    _dashboardLoading.value= value;
  }

  final _incidentDashboardList=<Map<String,dynamic>>[].obs;

  get incidentDashboardList => _incidentDashboardList.value;

  set incidentDashboardList(value) {
    _incidentDashboardList.value= value;
  }
  final _incidentDashboardListDummy=<Map<String,dynamic>>[].obs;

  get incidentDashboardListDummy => _incidentDashboardListDummy.value;

  set incidentDashboardListDummy(value) {
    _incidentDashboardListDummy.value= value;
  }
  getDashboard()async{
    dashboardLoading=true;
    var response=await repository.getDashboard();
    dashboardLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['IncidentData'].forEach((e){
        res.add(e);
      });
      incidentDashboardList=res;
      incidentDashboardListDummy=res;
    }else{
      incidentDashboardList=<Map<String,dynamic>>[];
      CommonToast.show(msg: "${response['message']}");
    }
  }
  final _showStaff=false.obs;

  get showStaff => _showStaff.value;

  set showStaff(value) {
    _showStaff.value = value;
  }
  // ------------------- division dropdown -------------------
  final _preparadByLoading = false.obs;

  get preparadByLoading => _preparadByLoading.value;

  set preparadByLoading(value) {
    _preparadByLoading.value = value;
  }

  final _preparadByEmpty = false.obs;

  get preparadByEmpty => _preparadByEmpty.value;

  set preparadByEmpty(value) {
    _preparadByEmpty.value = value;
  }


  final _preparadBy = <Map<String, dynamic>>[].obs;

  get preparadBy => _preparadBy.value;

  set preparadBy(value) {
    _preparadBy.value = value;
  }

  getPreparedByList() async {
    preparadByLoading = true;
    var response = await repository.getPreparedByList();
    preparadByLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['cost_centre'].forEach((e) {
        res.add(e);
      });
      preparadBy = res;
      preparadByEmpty = false;
    } else {
      preparadByEmpty = true;
      preparadBy = <Map<String, dynamic>>[];
    }
  }


  // ------------------- division dropdown -------------------
  final _statusLoading = false.obs;

  get statusLoading => _statusLoading.value;

  set statusLoading(value) {
    _statusLoading.value = value;
  }

  final _statusEmpty = false.obs;

  get statusEmpty => _statusEmpty.value;

  set statusEmpty(value) {
    _statusEmpty.value = value;
  }


  final _statusList = <Map<String, dynamic>>[].obs;

  get statusList => _statusList.value;

  set statusList(value) {
    _statusList.value = value;
  }

  getStatusList() async {
    statusLoading = true;
    var response = await repository.gettStatusList();
    statusLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['cost_centre'].forEach((e) {
        res.add(e);
      });
      statusList = res;
      statusEmpty = false;
    } else {
      statusEmpty = true;
      statusList = <Map<String, dynamic>>[];
    }
  }


  // ------------------- division dropdown -------------------
  final _reportByLoading = false.obs;

  get reportByLoading => _reportByLoading.value;

  set reportByLoading(value) {
    _reportByLoading.value = value;
  }

  final _reportByEmpty = false.obs;

  get reportByEmpty => _reportByEmpty.value;

  set reportByEmpty(value) {
    _reportByEmpty.value = value;
  }


  final _reportByList = <Map<String, dynamic>>[].obs;

  get reportByList => _reportByList.value;

  set reportByList(value) {
    _reportByList.value = value;
  }



  final _selectedFiles = <File>[].obs;

  get selectedFiles => _selectedFiles.value;

  set selectedFiles(value) {
    _selectedFiles.value = value;
  }

  geReportByList() async {
    reportByLoading = true;
    var response = await repository.getReportByList();
    reportByLoading = false;
    if (response['reportBy'] == true) {
      List<Map<String, dynamic>>res = [];
      response['cost_centre'].forEach((e) {
        res.add(e);
      });
      reportByList = res;
      reportByEmpty = false;
    } else {
      reportByEmpty = true;
      reportByList = <Map<String, dynamic>>[];
    }
  }



  saveIncidents()async{
    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String user_id=aswiniPrefs.getString("user_id")??"";

    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      // "incident_id":"ASW001",
      "subject":subject.text,
      "division_and_cost_centre":divisorCostCentre.text,
      "customer_name":customerName.text,
      "place_of_occurrence":placeOfAccurance.text,
      "date_and_time":dateAndTime.text,
      "employee_name":employeeName.text,
      "staff_id":staffId.text,
      "sgh_vehicle_number":sghVehicleNumber.text,
      "consignee_or_shipper":consigneeShipper.text,
      "mawb":mawb.text,
      "hawb":hawb.text,
      "total_qty_of_item":totalQuantityOfItem.text,
      "weight":weight.text,
      "qty_of_damged":quantityOfDamaged.text,
      "remarks":remarks.text,
      "corrective_action":correctionAction.text,
      "preventive_action":preventiveAction.text,
      "root_cause_analysis":rootCauseAnalysis.text,
      "created_by":user_id,
    };
    debugPrint("body before submit ${jsonEncode(body)}");
    var response =await repository.saveIncident(body: body);
    Get.back();
    if(response['status']==true){
      CommonToast.show(msg: "${response['message']}");
      clearFormField();
      Get.back();
      getDashboard();

    }else{
      CommonToast.show(msg: "${response['message']}");
    }
  }


  // ------------------- division dropdown -------------------
  final _divisionLoading=false.obs;

  get divisionLoading => _divisionLoading.value;

  set divisionLoading(value) {
    _divisionLoading.value = value;
  }

  final _divisionEmpty=false.obs;

  get divisionEmpty => _divisionEmpty.value;

  set divisionEmpty(value) {
    _divisionEmpty.value = value;
  }


  final _division=<Map<String, dynamic>>[].obs;

  get division => _division.value;

  set division(value) {
    _division.value = value;
  }

  getDivisionList()async{
    divisionLoading=true;
    var response=await repository.getDivisionList();
    divisionLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['cost_centre'].forEach((e){
        res.add(e);
      });
      division=res;
      divisionEmpty=false;

    }else{
      divisionEmpty=true;
      division=<Map<String,dynamic>>[];
    }
  }



  // -------------------employeeName dropdown -------------------
  final _employeeNameLoading=false.obs;

  get employeeNameLoading => _employeeNameLoading.value;

  set employeeNameLoading(value) {
    _employeeNameLoading.value = value;
  }

  final _employeeNameEmpty=false.obs;

  get employeeNameEmpty => _employeeNameEmpty.value;

  set employeeNameEmpty(value) {
    _employeeNameEmpty.value = value;
  }

  final _employeeNameList=<Map<String, dynamic>>[].obs;

  get employeeNameList => _employeeNameList.value;

  set employeeNameList(value) {
    _employeeNameList.value = value;
  }

  getEmployeeList()async{
    debugPrint("test getEmployeeList1");
    employeeNameLoading=true;
    var response=await repository.getEmployeeList();

    employeeNameLoading=false;
    if(response['status']==true){
      debugPrint("test getEmployeeList2$response");

      List<Map<String,dynamic>>res=[];
      response['employeeData'].forEach((e){
        res.add(e);
      });
      debugPrint("test getEmployeeList3");

      employeeNameList=res;
      employeeNameEmpty=false;
      debugPrint("test getEmployeeList4");

    }else{
      debugPrint("test getEmployeeList4");

      employeeNameEmpty=true;
      employeeNameList=<Map<String,dynamic>>[];
    }
  }

  final _sghVehicleLoading=false.obs;

  get sghVehicleLoading => _sghVehicleLoading.value;

  set sghVehicleLoading(value) {
    _sghVehicleLoading.value = value;
  }

  final _sghVehicleEmpty=false.obs;

  get sghVehicleEmpty => _sghVehicleEmpty.value;

  set sghVehicleEmpty(value) {
    _sghVehicleEmpty.value = value;
  }

  final _sghVehicleList=<Map<String, dynamic>>[].obs;

  get sghVehicleList => _sghVehicleList.value;

  set sghVehicleList(value) {
    _sghVehicleList.value = value;
  }

  getSGHVehicle()async{
    sghVehicleLoading=true;
    var response=await repository.getSGHVehicleList();
    sghVehicleLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['sghData'].forEach((e){
        res.add(e);
      });
      sghVehicleList=res;
      sghVehicleEmpty=false;

    }else{
      sghVehicleEmpty=true;
      sghVehicleList=<Map<String,dynamic>>[];
    }
  }

  final _correctiveActionLoading=false.obs;

  get correctiveActionLoading => _correctiveActionLoading.value;

  set correctiveActionLoading(value) {
    _correctiveActionLoading.value = value;
  }

  final _correctiveActionEmpty=false.obs;

  get correctiveActionEmpty => _correctiveActionEmpty.value;

  set correctiveActionEmpty(value) {
    _correctiveActionEmpty.value = value;
  }

  final _correctiveActionList=<Map<String, dynamic>>[].obs;

  get correctiveActionList => _correctiveActionList.value;

  set correctiveActionList(value) {
    _correctiveActionList.value = value;
  }

  getCorrectiveAction()async{
    correctiveActionLoading=true;
    var response=await repository.getCorrectiveActionList();
    correctiveActionLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['correctiveData'].forEach((e){
        res.add(e);
      });
      correctiveActionList=res;
      correctiveActionEmpty=false;

    }else{
      correctiveActionEmpty=true;
      correctiveActionList=<Map<String,dynamic>>[];
    }
  }


  final _preventiveActionLoading=false.obs;

  get preventiveActionLoading => _preventiveActionLoading.value;

  set preventiveActionLoading(value) {
    _preventiveActionLoading.value = value;
  }

  final _preventiveActionEmpty=false.obs;

  get preventiveActionEmpty => _preventiveActionEmpty.value;

  set preventiveActionEmpty(value) {
    _preventiveActionEmpty.value = value;
  }

  final _preventiveActionList=<Map<String, dynamic>>[].obs;

  get preventiveActionList => _preventiveActionList.value;

  set preventiveActionList(value) {
    _preventiveActionList.value = value;
  }

  getPreventiveAction()async{
    preventiveActionLoading=true;
    var response=await repository.getPreventiveActionList();
    preventiveActionLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['preventiveData'].forEach((e){
        res.add(e);
      });
      preventiveActionList=res;
      preventiveActionEmpty=false;

    }else{
      preventiveActionEmpty=true;
      preventiveActionList=<Map<String,dynamic>>[];
    }
  }



}