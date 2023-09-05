import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/data/repository/http/PropertyDamageRepository.dart';

import '../config/app_config.dart';
import '../data/repository/http/VehicleAccidentRepository.dart';
import '../ui/screens/demo/property_damage_viewform.dart';
import '../ui/widgets/commonToast.dart';
import '../ui/widgets/popup_loading.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
class PropertyDamageController extends GetxController {
  static PropertyDamageController get to =>
      Get.put(PropertyDamageController());
  TextEditingController search = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController preparedby = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController creatorNameController = TextEditingController();
  TextEditingController editorName = TextEditingController();
  TextEditingController reportby = TextEditingController();
  TextEditingController divisionCostCentre = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController placeOfAccurance = TextEditingController();
  TextEditingController dateAndTime = TextEditingController();
  TextEditingController employeeName = TextEditingController();
  TextEditingController staffId = TextEditingController();
  TextEditingController sghVehicleNumber = TextEditingController();
  TextEditingController briefDamageDescription = TextEditingController();
  TextEditingController thirdPartyName = TextEditingController();
  TextEditingController thirdPartyContactNumber = TextEditingController();
  TextEditingController thirdPartyVehicleNumber = TextEditingController();

  TextEditingController anyInjuryController = TextEditingController();
  TextEditingController briefDescriptionOfInjury = TextEditingController();

  // TextEditingController ambulanceInvolved = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController descriptionOfAccident = TextEditingController();
  TextEditingController correctiveAction = TextEditingController();
  TextEditingController preventiveAction = TextEditingController();
  TextEditingController rootCauseAnalysis = TextEditingController();
  // TextEditingController incidentUploads = TextEditingController();
  TextEditingController bodyParts = TextEditingController();
  TextEditingController insuranceReferenceNumber = TextEditingController();



  // TextEditingController search =TextEditingController();

  TextEditingController searchController = TextEditingController();

  TextEditingController subjectApp = TextEditingController();
  TextEditingController designationApp = TextEditingController();
  TextEditingController dateAndTimeApp = TextEditingController();
  TextEditingController descrioptionApp = TextEditingController();
  clearFormIncidentApprovals(){

    descrioptionApp.text="";
  }
  clearFilter(){
    reportby.text="";
    preparedby.text="";
    status.text="";
  }
  final _incidentUploads=[].obs;

  get incidentUploads => _incidentUploads.value;

  set incidentUploads(value) {
    _incidentUploads.value = value;
  }
  final _reportCont="".obs;

  get reportCont => _reportCont.value;

  set reportCont(value) {
    _reportCont.value = value;
  }

  final _showsectionSection="".obs;

  get showsectionSection => _showsectionSection.value;

  set showsectionSection(value) {
    _showsectionSection.value = value;
  }
  final _viewButton=false.obs;

  get viewButton => _viewButton.value;

  set viewButton(value) {
    _viewButton.value = value;
  }

  final _statusCont="".obs;

  get statusCont => _statusCont.value;

  set statusCont(value) {
    _statusCont.value = value;
  }

  final _preparadCont="".obs;

  get preparadCont => _preparadCont.value;

  set preparadCont(value) {
    _preparadCont.value = value;
  }


  init() {
    Future.delayed(Duration(seconds: 0),(){

    });
    debounce(_searchValue, (value) async {
      debugPrint("entry of search controlle");
      debugPrint('*******************************');

      PropertyDamageController.to.getDashboard();
    },
        time:AppConfig.debounceDuration);
  }
  final _searchValue ="".obs;

  get searchValue => _searchValue.value;

  set searchValue(value) {
    _searchValue.value = value;
  }





  final repository=PropertyDamageRepository();
  final _showStaff=false.obs;
  final _anyInjury = "Yes".obs;

  get anyInjury => _anyInjury.value;

  set anyInjury(value) {
    _anyInjury.value = value;
  }
  final _senddivisorCostCentreId="".obs;

  get senddivisorCostCentreId => _senddivisorCostCentreId.value;

  set senddivisorCostCentreId(value) {
    _senddivisorCostCentreId.value = value;
  }
  final _sendEmployeeNameId="".obs;

  get sendEmployeeNameId => _sendEmployeeNameId.value;

  set sendEmployeeNameId(value) {
    _sendEmployeeNameId.value = value;
  }
  final _showBodyParts=false.obs;

  get showBodyParts => _showBodyParts.value;

  set showBodyParts(value) {
    _showBodyParts.value = value;
  }

  final _ambulanceInvolved = "Yes".obs;

  get ambulanceInvolved => _ambulanceInvolved.value;

  set ambulanceInvolved(value) {
    _ambulanceInvolved.value = value;
  }
  get showStaff => _showStaff.value;

  set showStaff(value) {
    _showStaff.value = value;
  }
  final _viewDropdown=false.obs;

  get viewDropdown => _viewDropdown.value;

  set viewDropdown(value) {
    _viewDropdown.value = value;
  }
  final _selectedFiles = <File>[].obs;

  get selectedFiles => _selectedFiles.value;

  set selectedFiles(value) {
    _selectedFiles.value = value;
  }
  final _showButton=false.obs;

  get showButton => _showButton.value;

  set showButton(value) {
    _showButton.value = value;
  }
  final _showImage=false.obs;

  get showImage => _showImage.value;

  set showImage(value) {
    _showImage.value = value;
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


  final _creatorName= <Map<String, dynamic>>[].obs;

  get creatorName => _creatorName.value;

  set creatorName(value) {
    _creatorName.value = value;
  }

  getCreaterNameList()async{
    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String creator_id=aswiniPrefs.getString("creator_id")??"";
    String creator_name=aswiniPrefs.getString("creator_name")??"";

    createrNameLoading=true;
    var response=await repository.getCreaterNameList();
    createrNameLoading=false;
    if(response['success']==true){
      List<Map<String, dynamic>>res = [];
      response['preventiveData'].forEach((e) {
        res.add(e);
      });
        createrNameEmpty=false;
        creatorName=response['data'];
      }else{
        createrNameEmpty=true;
        creatorName=<Map<String, dynamic>>[];
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


  final _editorNewName= <Map<String, dynamic>>[].obs;

  get editorNewName => _editorNewName.value;

  set editorNewName(value) {
    _editorNewName.value = value;
  }

  getEditorNameList()async{
    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String editor_id=aswiniPrefs.getString("editor_id")??"";
    String editor_name=aswiniPrefs.getString("editor_name")??"";
    editorNameLoading=true;
    var response=await repository.getEditorNameList();
    editorNameLoading=false;
    if(response['success']==true){
      List<Map<String, dynamic>>res = [];
      response['preventiveData'].forEach((e) {
        res.add(e);
      });
        editorNameEmpty=false;
        editorName=response['data'];
      }else{
        editorNameEmpty=true;
        editorNewName=<Map<String, dynamic>>[];
      }
    }




  clearFormField() async{

    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();

    String creator_name=aswiniPrefs.getString("creator_name")??"";
    String editor_name=aswiniPrefs.getString("editor_name")??"";
    subject.text = "";
    creatorNameController.text=creator_name;
    editorName.text=editor_name;
    divisionCostCentre.text = "";
    customerName.text = "";
    placeOfAccurance.text = "";
    dateAndTime.text = "";
    employeeName.text = "";
    staffId.text = "";
    sghVehicleNumber.text = "";
    briefDamageDescription.text = "";
    thirdPartyName.text = "";
    thirdPartyContactNumber.text = "";
    thirdPartyVehicleNumber.text = "";
    // anyInjury.text="";
    briefDescriptionOfInjury.text = "";
    // anyAmbulance.text="";
    bodyParts.text="";
    remarks.text = "";
    descriptionOfAccident.text = "";
    correctiveAction.text = "";
    preventiveAction.text = "";
    rootCauseAnalysis.text = "";
    insuranceReferenceNumber.text="";
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

  final _ambulaneInoled="Yes".obs;

  get ambulaneInoled => _ambulaneInoled.value;

  set ambulaneInoled(value) {
    _ambulaneInoled.value = value;
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
      response['preparatedBy'].forEach((e) {
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
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['ReportNo'].forEach((e) {
        res.add(e);
      });
      reportByList = res;
      reportByEmpty = false;
    } else {
      reportByEmpty = true;
      reportByList = <Map<String, dynamic>>[];
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
  clearFilterVariable(){
    reportCont="";
    preparadCont="";
    statusCont="";
  }
  getDashboard()async{
    var body ="report_no=${reportCont}&praparated_by=${preparadCont}&status=${statusCont}";

    dashboardLoading=true;
    var response=await repository.getDashboard(body: '$body');
    dashboardLoading=false;
    if(response['status']==true){
      List<Map<String,dynamic>>res=[];
      response['PropertyData'].forEach((e){
        res.add(e);
      });
      incidentDashboardList=res;
      incidentDashboardListDummy=res;
    }else{
      incidentDashboardList=<Map<String,dynamic>>[];
      CommonToast.show(msg: "${response['message']}");
    }
  }

  setDataForUpdate({required String ID,required bool ignoring,required bool canShowSection2ForApprovals})async{
    CommonScreenLoading.show(text: "Getting  data ...");
    clearFormIncidentApprovals();
    clearFormField();
//setting the field
    var response = await repository.getIncidentViewList(Id: ID);
    Get.back();

    debugPrint("check id is=${response}");
    if(response['status']==true){
      var IncidentId=response['preventiveView'];
      subject.text="${IncidentId['subject']}"??"";
      // character="${IncidentId['inctype']}"=="1"?"Near Miss":"${IncidentId['inctype']}"=="2"?"Customer Complaints":"${IncidentId['inctype']}"=="3"?"General Incidents":"General Incidents";

      divisionCostCentre.text="${IncidentId['division_and_cost_centre']}"??"";
      customerName.text="${IncidentId['customer_name']}"??"";
      placeOfAccurance.text="${IncidentId['place_of_occurrence']}"??"";
      dateAndTime.text="${IncidentId['date_and_time']}"??"";
      bodyParts.text="${IncidentId['body_parts']}"??"";
      employeeName.text="${IncidentId['employee_name']}"??"";
      staffId.text="${IncidentId['staff_id']}"??"";
      sghVehicleNumber.text="${IncidentId['sgh_vehicle_number']}"??"";
      briefDamageDescription.text="${IncidentId['brief_damage_description']}"??"";
      thirdPartyName.text="${IncidentId['third_party_name']}"??"";
      thirdPartyContactNumber.text="${IncidentId['third_party_contact_number']}"??"";
      thirdPartyVehicleNumber.text="${IncidentId['third_party_vehicle_number']}"??"";
      anyInjury="${IncidentId['any_injury']}"=="1"?"Yes":"${IncidentId['any_injury']}"=="2"?"No":"Yes";
      briefDescriptionOfInjury.text="${IncidentId['brief_description_of_injury']}"??"";
      ambulaneInoled="${IncidentId['ambulance_invloved']}"=="1"?"Yes":"${IncidentId['ambulance_invloved']}"=="2"?"No":"Yes";
      remarks.text="${IncidentId['remarks']}"??"";
      descriptionOfAccident.text="${IncidentId['description_of_accident'].length}"??"";
      correctiveAction.text="${IncidentId['corrective_action']}"??"";
      preventiveAction.text="${IncidentId['preventive_action']}"??"";
      rootCauseAnalysis.text="${IncidentId['root_cause_analysis']}"??"";
      insuranceReferenceNumber.text="${IncidentId['insurance_reference_number']}"??"";
      showsectionSection="${IncidentId['property_status']}"??"";
      incidentUploads=response['imgUpload']==null?[]:response['imgUpload'];
      List<File> files=[];
      if(incidentUploads.isNotEmpty) {
        for(int i=0;i<incidentUploads.length;i++){
          final extension = p.extension(incidentUploads[i]['uploadfile_path']); // '.dart'
          final filename =  "${incidentUploads[i]['uploadfile_path']}".split("/")[5];
          debugPrint("extension of file name ${extension}");
          debugPrint("file name ${filename}");
          final http.Response responseData = await http.get(Uri.parse(
              "${AppConfig.imgUrl}${incidentUploads[i]['uploadfile_path']}"));
          Uint8List uint8list = responseData.bodyBytes;
          var buffer = uint8list.buffer;
          ByteData byteData = ByteData.view(buffer);
          var tempDir = await getTemporaryDirectory();
          var documentDir = Directory('${tempDir.path}/document');
          if (!documentDir.existsSync()) {
            documentDir.createSync(recursive: true);
          }
          File file = await File('${documentDir.path}/$filename')
              .writeAsBytes(
              buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
          files.add( File(file.path));

        }}
      PropertyDamageController.to.selectedFiles.addAll(files);
      debugPrint("iiiimages${  PropertyDamageController.to.selectedFiles}");

      //  incidentUploads.text="${response['imgUpload'][index]['uploadfile_path']}"??"as";

      // incidentUploads.text="as";
      Get.to(() => PropertyDamageViewForms(
        ignoring: ignoring,
        canShowSection2ForApprovals:canShowSection2ForApprovals,

        property_user_id: '${ID}',
      ));
    }else{
      CommonToast.show(msg: "${response['message']}");

    }


    debugPrint("check get datas");
  }
  saveAccidents()async{
    debugPrint("body before submit vehicle accident");

    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String user_id=aswiniPrefs.getString("user_id")??"";
    String creator_id=aswiniPrefs.getString("creator_id")??"";
    String editor_id=aswiniPrefs.getString("editor_id")??"";
    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      "subject":subject.text,
      "division_and_cost_centre":senddivisorCostCentreId,
      "customer_name":customerName.text,
      "creator_name":creator_id,
      "editor_name":editor_id,
      "place_of_occurrence":placeOfAccurance.text,
      "date_and_time":dateAndTime.text,
      "employee_name":sendEmployeeNameId,
      "staff_id":staffId.text,
      "sgh_vehicle_number":sghVehicleNumber.text,
      "brief_damage_description": briefDamageDescription.text,
      "third_party_name": thirdPartyName.text,
      "third_party_contact_number": thirdPartyContactNumber.text,
      "insurance_reference_number": insuranceReferenceNumber.text,

      "any_injury": "${anyInjury}"=="Yes"?"1":"${anyInjury}"=="No"?"2":"2",
      "body_parts":bodyParts.text,
      // "brief_description_of_injury":briefDescriptionOfInjury.text,
      "any_ambulance":"${ambulanceInvolved}"=="Yes"?"1":"${ambulanceInvolved}"=="No"?"2":"2",
      "remarks":remarks.text,
      "description_of_accident":descriptionOfAccident.text,
      "corrective_action":correctiveAction.text,
      "preventive_action":preventiveAction.text,
      "root_cause_analysis":rootCauseAnalysis.text,
      "created_by":user_id,
    };
    debugPrint("aswinitrestppp${briefDamageDescription.text}");

    debugPrint("aswinitrestp${thirdPartyName.text}");

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
  updateAccidents({required String user_id})async{
    debugPrint("body before submit vehicle accident");

    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();

    String creator_id=aswiniPrefs.getString("creator_id")??"";
    String editor_id=aswiniPrefs.getString("editor_id")??"";

    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      "id":user_id,
      "subject":subject.text,
      "division_and_cost_centre":senddivisorCostCentreId,
      "customer_name":customerName.text,
      "creator_name":creator_id,
      "editor_name":editor_id,
      "place_of_occurrence":placeOfAccurance.text,
      "date_and_time":dateAndTime.text,
      "employee_name":sendEmployeeNameId,
      "staff_id":staffId.text,
      "sgh_vehicle_number":sghVehicleNumber.text,
      "brief_damage_description": briefDamageDescription.text,
      "third_party_name": thirdPartyName.text,
      "third_party_contact_number": thirdPartyContactNumber.text,
      "insurance_reference_number": insuranceReferenceNumber.text,

      "any_injury": "${anyInjury}"=="Yes"?"1":"${anyInjury}"=="No"?"2":"2",
      "body_parts":bodyParts.text,
      // "brief_description_of_injury":briefDescriptionOfInjury.text,
      "any_ambulance":"${ambulanceInvolved}"=="Yes"?"1":"${ambulanceInvolved}"=="No"?"2":"2",
      "remarks":remarks.text,
      "description_of_accident":descriptionOfAccident.text,
      "corrective_action":correctiveAction.text,
      "preventive_action":preventiveAction.text,
      "root_cause_analysis":rootCauseAnalysis.text,
      "created_by":user_id,
    };
    debugPrint("aswinitrestppp${briefDamageDescription.text}");

    debugPrint("aswinitrestp${thirdPartyName.text}");

    debugPrint("body before submit ${jsonEncode(body)}");
    var response =await repository.saveIncident(body: body);
    Get.back();
    if(response['status']==true){
      CommonToast.show(msg: "${response['message']}");
      Get.back();
      getDashboard();

    }else{
      CommonToast.show(msg: "${response['message']}");
    }
  }
  updateIncidentApprovals({required String property_user_id,required String approveId})async{
    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String user_id=aswiniPrefs.getString("user_id")??"";
    String user_name=aswiniPrefs.getString("user_name")??"";
    String designation_name=aswiniPrefs.getString("designation_name")??"";

    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      "property_id":property_user_id,
      "user_id":user_id,
      "username":user_name,
      "designation":designation_name,
      "date_time":dateAndTimeApp.text,
      "approve_id":approveId,
      "description":descrioptionApp.text,
      "property_status":1,

    };
    debugPrint("body before submit ${jsonEncode(body)}");
    var response =await repository.UpdateIncidentApproval(body: jsonEncode(body));
    Get.back();
    if(response['status']==true){
      CommonToast.show(msg: "${response['message']}");
      Get.back();

      getDashboard();
      clearFormIncidentApprovals();
    }else{
      CommonToast.show(msg: "${response['message']}");
    }
  }
  getDataForApprovals({required String property_user_id,})async{
    Map<String,dynamic> body= {
      "pro_id":property_user_id,
    };

    var response = await repository.setDataForApprovals(body: jsonEncode(body));

    debugPrint("check id is=${response}");
    if(response['status']==true){
      var ApproveData=response['ApproveData'];

      subjectApp.text="${ApproveData['username']}"??"";
      designationApp.text="${ApproveData['designation']}"??"";
      dateAndTimeApp.text="${ApproveData['date_time']}"??"";
      descrioptionApp.text="${ApproveData['description']}"??"";


      // incidentUploads.text="as";

    }
    debugPrint("check get datas");
  }




}

