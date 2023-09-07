import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/ui/widgets/commonToast.dart';
import 'package:sofproject/app/ui/widgets/popup_loading.dart';

import '../config/app_config.dart';
import '../data/repository/http/incidentFormsRepository.dart';
import '../ui/screens/demo/incident_view_form_screen.dart';
import '../ui/widgets/commonExpandableRadioButton.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
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
 // TextEditingController incidentUploads = TextEditingController();
 // TextEditingController search =TextEditingController();

  TextEditingController searchController = TextEditingController();

  TextEditingController subjectApp = TextEditingController();
  TextEditingController designationApp = TextEditingController();
  TextEditingController dateAndTimeApp = TextEditingController();
  TextEditingController descrioptionApp = TextEditingController();


  init() {
    Future.delayed(Duration(seconds: 0),(){

    });
    debounce(_searchValue, (value) async {
      debugPrint("entry of search controlle");
      debugPrint('*******************************');

      IncidentController.to.getDashboard();
    },
        time:AppConfig.debounceDuration);
  }
  final _searchValue ="".obs;

  get searchValue => _searchValue.value;

  set searchValue(value) {
    _searchValue.value = value;
  }
final _refreshValue=false.obs;

  get refreshValue => _refreshValue.value;

  set refreshValue(value) {
    _refreshValue.value = value;
  }

  final repository=IncidentFormRepository();
final _senddivisorCostCentreId="".obs;

  get senddivisorCostCentreId => _senddivisorCostCentreId.value;

  set senddivisorCostCentreId(value) {
    _senddivisorCostCentreId.value = value;
  }
  final _getStatusApproval="".obs;

  get getStatusApproval => _getStatusApproval.value;

  set getStatusApproval(value) {
    _getStatusApproval.value = value;
  }

  final _sendEmployeeNameId="".obs;

  get sendEmployeeNameId => _sendEmployeeNameId.value;

  set sendEmployeeNameId(value) {
    _sendEmployeeNameId.value = value;
  }
  final _character = "Near Miss".obs;

  get character => _character.value;

  set character(value) {
    _character.value = value;
  }
  final _showsectionSection="".obs;

  get showsectionSection => _showsectionSection.value;

  set showsectionSection(value) {
    _showsectionSection.value = value;
  }

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
    correctionAction.text="";
    preventiveAction.text="";
    rootCauseAnalysis.text="";
  }

  clearFormIncidentApprovals(){

    descrioptionApp.text="";
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

  final _reportCont="".obs;

  get reportCont => _reportCont.value;

  set reportCont(value) {
    _reportCont.value = value;
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

  final _subjectCont="".obs;

  get subjectCont => _subjectCont.value;

  set subjectCont(value) {
    _subjectCont.value = value;
  }
  clearFilter(){
    reportby.text="";
    subject.text="";
    preparedby.text="";
    status.text="";
  }
  clearFilterVariable(){
    reportCont="";
    subjectCont="";
    preparadCont="";
    statusCont="";
  }

  final _notificationLoading=false.obs;

  get notificationLoading => _notificationLoading.value;

  set notificationLoading(value) {
    _notificationLoading.value = value;
  }

  final _notificationsList=[].obs;

  get notificationsList => _notificationsList.value;

  set notificationsList(value) {
    _notificationsList.value= value;
  }

  final _notificationsCount=0.obs;

  get notificationsCount => _notificationsCount.value;

  set notificationsCount(value) {
    _notificationsCount.value= value;
  }

  getNotification()async{
    notificationLoading=true;
    var res=await repository.getNotification();
    notificationLoading=false;
    if(res['status']==true){
      notificationsList=res['Notification']??[];
      notificationsCount=res['Notification']==null?0:res['Notification'].length;
    }else{
      notificationsList=[];
      notificationsCount=0;
    }
  }

  getDashboard()async{
    var body ="report_no=${reportCont}&subject=${subjectCont}&praparated_by=${preparadCont}&status=${statusCont}";
    dashboardLoading=true;
    var response=await repository.getDashboard(body: '$body');
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
    if (response['status'] == true) {
      List<Map<String, dynamic>>res = [];
      response['ReportNo'].forEach((e) {
        res.add(e);
      });
      reportByList = res;
      debugPrint("ghjdsgfjhfhdsbfhjb${response['ReportNo']}");

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
         //"inctype":"${character}",
      "inctype": "${character}"=="Near Miss"?"1":"${character}"=="Customer Complaints"?"2":"${character}"=="General Incidents"?"3":"3",
      "subject":subject.text,
      "division_and_cost_centre":senddivisorCostCentreId,
      "customer_name":customerName.text,
      "place_of_occurrence":placeOfAccurance.text,
      "date_and_time":dateAndTime.text,
      "employee_name":sendEmployeeNameId,
      "staff_id":staffId.text,
      "sgh_vehicle_number":sghVehicleNumber.text,
      "consignee_or_shipper":consigneeShipper.text,
      "mawb":mawb.text,
      "hawb":hawb.text,
      "total_qty_of_item":totalQuantityOfItem.text,
      "weight":weight.text,
      "qty_of_Damaged":quantityOfDamaged.text,
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

  final _viewButton=false.obs;

  get viewButton => _viewButton.value;

  set viewButton(value) {
    _viewButton.value = value;
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
  final _incidentUploads=[].obs;

  get incidentUploads => _incidentUploads.value;

  set incidentUploads(value) {
    _incidentUploads.value = value;
  }

  setDataForUpdate({required String ID,required bool ignoring,required bool canShowSection2ForApprovals})async{
    selectedFiles=<File>[];

    CommonScreenLoading.show(text: "Getting  data ...");
    clearFormIncidentApprovals();
    clearFormField();
    IncidentController.to.selectedFiles=<File>[];
//setting the field
    var response = await repository.getIncidentViewList(Id: ID);
    Get.back();
    debugPrint("check id is=${response}");
    if(response['status']==true){
      var IncidentId=response['IncidentView'];
      character="${IncidentId['inctype']}"=="1"?"Near Miss":"${IncidentId['inctype']}"=="2"?"Customer Complaints":"${IncidentId['inctype']}"=="3"?"General Incidents":"General Incidents";
      subject.text="${IncidentId['subject']}"??"";
      divisorCostCentre.text="${IncidentId['division_and_cost_centre']}"??"";
      customerName.text="${IncidentId['customer_name']}"??"";
      placeOfAccurance.text="${IncidentId['place_of_occurrence']}"??"";
      dateAndTime.text="${IncidentId['date_and_time']}"??"";
      dateAndTimeApp.text="${IncidentId['date_and_time']}"??"";
      employeeName.text="${IncidentId['employee_name']}"??"";
      staffId.text="${IncidentId['staff_id']}"??"";
      sghVehicleNumber.text="${IncidentId['sgh_vehicle_number']}"??"";
      consigneeShipper.text="${IncidentId['consignee_or_shipper']}"??"";
      mawb.text="${IncidentId['mawb']}"??"";
      hawb.text="${IncidentId['hawb']}"??"";
      totalQuantityOfItem.text="${IncidentId['total_qty_of_item']}"??"";
      weight.text="${IncidentId['weight']}"??"";
      quantityOfDamaged.text="${IncidentId['qty_of_Damaged']}"??"";
      remarks.text="${IncidentId['remarks']==null?"N/A":IncidentId['remarks']==""?"N/A":IncidentId['remarks']}";
      correctionAction.text="${IncidentId['corrective_action']}"??"";
      preventiveAction.text="${IncidentId['preventive_action']}"??"";
      rootCauseAnalysis.text="${IncidentId['root_cause_analysis']}"??"";
   // incidentUploads.text="${IncidentId['incident_uploads'].length}"??"";
    //  incidentUploads.text="${response['imgUpload'][index]['uploadfile_path']}"??"as";
   //  incidentUploads.text=IncidentId['incident_uploads']==null?"0":"${IncidentId['incident_uploads']}";
     // incidentUploads.text=response['imgUpload']==null?"0":"${response['imgUpload'].length}";
      // incidentUploads.text="as";
      showsectionSection="${IncidentId['incident_status']}"??"";

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
      IncidentController.to.selectedFiles.addAll(files);
      debugPrint("iiiimages${  IncidentController.to.selectedFiles}");

      // IncidentController.to.selectedFiles



      Get.to(() => IncidentViewFormScreen(
        ignoring: ignoring,
        canShowSection2ForApprovals:canShowSection2ForApprovals,
        incident_user_id: '${ID}',
      ));
    }else{

      CommonToast.show(msg: "${response['message']}");
    }

    debugPrint("check get datas");
  }

  updateIncidents({required String user_id})async{
    // SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    // String user_id=aswiniPrefs.getString("user_id")??"";

    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      "id":user_id,
      "inctype": "${character}"=="Near Miss"?"1":"${character}"=="Customer Complaints"?"2":"${character}"=="General Incidents"?"3":"3",
      "subject":subject.text,
      "division_and_cost_centre":senddivisorCostCentreId,
      "customer_name":customerName.text,
      "place_of_occurrence":placeOfAccurance.text,
      "date_and_time":dateAndTime.text,
      "employee_name":sendEmployeeNameId,
      "staff_id":staffId.text,
      "sgh_vehicle_number":sghVehicleNumber.text,
      "consignee_or_shipper":consigneeShipper.text,
      "mawb":mawb.text,
      "hawb":hawb.text,
      "total_qty_of_item":totalQuantityOfItem.text,
      "weight":weight.text,
      "qty_of_Damaged":quantityOfDamaged.text,
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
      Get.back();

      getDashboard();

    }else{
      CommonToast.show(msg: "${response['message']}");
    }
  }

  updateIncidentApprovals({required String incident_user_id,required String approveId})async{
    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    String user_id=aswiniPrefs.getString("user_id")??"";
    String user_name=aswiniPrefs.getString("user_name")??"";
    String designation_name=aswiniPrefs.getString("designation_name")??"";

    CommonScreenLoading.show(text: "Saving...");
    Map<String,dynamic> body={
      "incident_id":incident_user_id,

      "user_id":user_id,
      "username":user_name,
      "designation":designation_name,
      "date_time":dateAndTimeApp.text,
      "approve_id":approveId,
      "description":descrioptionApp.text,
      "incident_status":1,

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
  getDataForApprovals({required String incident_user_id,})async{
    Map<String,dynamic> body= {
      "inc_id":incident_user_id,
    };

    var response = await repository.setDataForApprovals(body: jsonEncode(body));

    debugPrint("check id is=${response}");
    if(response['status']==true){
      var ApproveData=response['ApproveData'];

      subjectApp.text="${ApproveData['username']}"??"";
      designationApp.text="${ApproveData['designation']}"??"";
      dateAndTimeApp.text="${ApproveData['date_time']}"??"";
      descrioptionApp.text="${ApproveData['description']??""}";


      // incidentUploads.text="as";

    }else{
    }
    debugPrint("check get datas");
  }





}
