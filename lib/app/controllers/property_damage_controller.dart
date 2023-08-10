import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../config/app_config.dart';
import '../data/repository/http/PropertyDamageRepository.dart';
import '../data/repository/http/incidentFormsRepository.dart';
import '../ui/widgets/commonToast.dart';

class PropertyDamageController extends GetxController{
  static PropertyDamageController get to => Get.put(PropertyDamageController());
  TextEditingController search =TextEditingController();
  TextEditingController preparedby = TextEditingController();
  TextEditingController status = TextEditingController();

  TextEditingController reportby = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController divisionCostCentre = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController createrName = TextEditingController();
  TextEditingController editorName = TextEditingController();
  TextEditingController placeOfAccurance = TextEditingController();
  TextEditingController dateAndTime = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController staffId = TextEditingController();
  TextEditingController sghVehicleNumber = TextEditingController();
  TextEditingController briefDamageDescription = TextEditingController();
  // TextEditingController anyInjury = TextEditingController();
  // TextEditingController anyAmbulance = TextEditingController();
  TextEditingController thirdPartyName = TextEditingController();
  TextEditingController thirdPartyContactNumber = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController descriptionOfAccident = TextEditingController();
  TextEditingController correctiveAction = TextEditingController();
  TextEditingController preventiveAction = TextEditingController();
  TextEditingController insuranceReferenceNumber = TextEditingController();
  TextEditingController rootCauseAnalysis = TextEditingController();

  final _showStaff=false.obs;

  get showStaff => _showStaff.value;

  set showStaff(value) {
    _showStaff.value = value;
  }

  final repository =PropertyDamageRepository();
  clearFormField(){
    preparedby.text="";
    status.text="";
    reportby.text="";
    subject.text="";
    divisionCostCentre.text="";
    customerName.text="";
    createrName.text="";
    editorName.text="";
    placeOfAccurance.text="";
    dateAndTime.text="";
    employeeName.text="";
    staffId.text="";
    sghVehicleNumber.text="";
    briefDamageDescription.text="";
    // anyInjury.text="";
    // anyAmbulance.text="";
    thirdPartyName.text="";
    thirdPartyContactNumber.text="";
    remarks.text="";
    descriptionOfAccident.text="";
    correctiveAction.text="";
    preventiveAction.text="";
    insuranceReferenceNumber.text="";
    rootCauseAnalysis.text="";
  }

  // ------------------- division dropdown -------------------
  final _divisionLoading = false.obs;

  get divisionLoading => _divisionLoading.value;

  set divisionLoading(value) {
    _divisionLoading.value = value;
  }

  final _divisionEmpty = false.obs;

  get divisionEmpty => _divisionEmpty.value;

  set divisionEmpty(value) {
    _divisionEmpty.value = value;
  }


  final _division = <Map<String, dynamic>>[].obs;

  get division => _division.value;

  set division(value) {
    _division.value = value;
  }

  getDivisionList() async {
    divisionLoading = true;
    var response = await repository.getDivisionList();
    divisionLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['cost_centre'].forEach((e) {
        res.add(e);
      });
      division = res;
      divisionEmpty = false;
    } else {
      divisionEmpty = true;
      division = <Map<String, dynamic>>[];
    }
  }

  // ------------------- createrName dropdown -------------------
  final _createrNameLoading=false.obs;

  get createrNameLoading => _createrNameLoading.value;

  set createrNameLoading(value) {
    _createrNameLoading.value = value;
  }

  final _createrNameEmpty=false.obs;

  get createrNameEmpty => _createrNameEmpty.value;

  set createrNameEmpty(value) {
    _createrNameEmpty.value = value;
  }


  final _creatorName=[].obs;

  get creatorName => _creatorName.value;

  set creatorName(value) {
    _creatorName.value = value;
  }

  getCreaterNameList()async{
    createrNameLoading=true;
    var res=await repository.getCreaterNameList();
    createrNameLoading=false;
    if(res['success']==true){
      if(res['data'].isNotEmpty){
        createrNameEmpty=false;
        creatorName=res['data'];
      }else{
        createrNameEmpty=true;
        creatorName=[];
      }
    }

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



  // ------------------- editorName dropdown -------------------
  final _editorNameLoading=false.obs;

  get editorNameLoading => _editorNameLoading.value;

  set editorNameLoading(value) {
    _editorNameLoading.value = value;
  }

  final _editorNameEmpty=false.obs;

  get editorNameEmpty => _editorNameEmpty.value;

  set editorNameEmpty(value) {
    _editorNameEmpty.value = value;
  }


  final _editorNewName=[].obs;

  get editorNewName => _editorNewName.value;

  set editorNewName(value) {
    _editorNewName.value = value;
  }

  getEditorNameList()async{
    editorNameLoading=true;
    var res=await repository.getEditorNameList();
    editorNameLoading=false;
    if(res['success']==true){
      if(res['data'].isNotEmpty){
        editorNameEmpty=false;
        editorName=res['data'];
      }else{
        editorNameEmpty=true;
        editorNewName=[];
      }
    }

  }



  // -------------------employeeName dropdown -------------------
  final _employeeNameLoading = false.obs;

  get employeeNameLoading => _employeeNameLoading.value;

  set employeeNameLoading(value) {
    _employeeNameLoading.value = value;
  }

  final _employeeNameEmpty = false.obs;

  get employeeNameEmpty => _employeeNameEmpty.value;

  set employeeNameEmpty(value) {
    _employeeNameEmpty.value = value;
  }

  final _employeeNameList = <Map<String, dynamic>>[].obs;

  get employeeNameList => _employeeNameList.value;

  set employeeNameList(value) {
    _employeeNameList.value = value;
  }

  getEmployeeList() async {
    debugPrint("test getEmployeeList1");
    employeeNameLoading = true;
    var response = await repository.getEmployeeList();

    employeeNameLoading = false;
    if (response['status'] == true) {
      debugPrint("test getEmployeeList2$response");

      List<Map<String, dynamic>>res = [];
      response['employeeData'].forEach((e) {
        res.add(e);
      });
      debugPrint("test getEmployeeList3");

      employeeNameList = res;
      employeeNameEmpty = false;
      debugPrint("test getEmployeeList4");
    } else {
      debugPrint("test getEmployeeList4");

      employeeNameEmpty = true;
      employeeNameList = <Map<String, dynamic>>[];
    }
  }

  final _sghVehicleLoading = false.obs;

  get sghVehicleLoading => _sghVehicleLoading.value;

  set sghVehicleLoading(value) {
    _sghVehicleLoading.value = value;
  }

  final _sghVehicleEmpty = false.obs;

  get sghVehicleEmpty => _sghVehicleEmpty.value;

  set sghVehicleEmpty(value) {
    _sghVehicleEmpty.value = value;
  }

  final _sghVehicleList = <Map<String, dynamic>>[].obs;

  get sghVehicleList => _sghVehicleList.value;

  set sghVehicleList(value) {
    _sghVehicleList.value = value;
  }

  getSGHVehicle() async {
    sghVehicleLoading = true;
    var response = await repository.getSGHVehicleList();
    sghVehicleLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['sghData'].forEach((e) {
        res.add(e);
      });
      sghVehicleList = res;
      sghVehicleEmpty = false;
    } else {
      sghVehicleEmpty = true;
      sghVehicleList = <Map<String, dynamic>>[];
    }
  }

  final _correctiveActionLoading = false.obs;

  get correctiveActionLoading => _correctiveActionLoading.value;

  set correctiveActionLoading(value) {
    _correctiveActionLoading.value = value;
  }

  final _correctiveActionEmpty = false.obs;

  get correctiveActionEmpty => _correctiveActionEmpty.value;

  set correctiveActionEmpty(value) {
    _correctiveActionEmpty.value = value;
  }

  final _correctiveActionList = <Map<String, dynamic>>[].obs;

  get correctiveActionList => _correctiveActionList.value;

  set correctiveActionList(value) {
    _correctiveActionList.value = value;
  }

  getCorrectiveAction() async {
    correctiveActionLoading = true;
    var response = await repository.getCorrectiveActionList();
    correctiveActionLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['correctiveData'].forEach((e) {
        res.add(e);
      });
      correctiveActionList = res;
      correctiveActionEmpty = false;
    } else {
      correctiveActionEmpty = true;
      correctiveActionList = <Map<String, dynamic>>[];
    }
  }


  final _preventiveActionLoading = false.obs;

  get preventiveActionLoading => _preventiveActionLoading.value;

  set preventiveActionLoading(value) {
    _preventiveActionLoading.value = value;
  }

  final _preventiveActionEmpty = false.obs;

  get preventiveActionEmpty => _preventiveActionEmpty.value;

  set preventiveActionEmpty(value) {
    _preventiveActionEmpty.value = value;
  }

  final _preventiveActionList = <Map<String, dynamic>>[].obs;

  get preventiveActionList => _preventiveActionList.value;

  set preventiveActionList(value) {
    _preventiveActionList.value = value;
  }

  getPreventiveAction() async {
    preventiveActionLoading = true;
    var response = await repository.getPreventiveActionList();
    preventiveActionLoading = false;
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['preventiveData'].forEach((e) {
        res.add(e);
      });
      preventiveActionList = res;
      preventiveActionEmpty = false;
    } else {
      preventiveActionEmpty = true;
      preventiveActionList = <Map<String, dynamic>>[];
    }
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



}