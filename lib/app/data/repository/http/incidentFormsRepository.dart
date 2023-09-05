import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';

import '../../../controllers/incident_controller.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as logDev;

class IncidentFormRepository{
  static final HttpHelper _http = HttpHelper();


  getDashboard({required String body}) async {
    var response = await _http.get("${Api.getIncidentDashboard}$body");
    return jsonDecode(response);
  }
  getNotification() async {
    var response = await _http.get("${Api.getNotification}");
    return jsonDecode(response);
  }


  saveIncident({required body}) async {
    var list=[];
    Map<String, MultipartFile> fileMap = {};
    Map<String, File> getFile= {};
    for(int i=0;i< IncidentController.to.selectedFiles.length;i++){
      getFile.addAll({
        "$i": IncidentController.to.selectedFiles[i]
        });
   }
    for (MapEntry fileEntry in getFile.entries) {
      File file = fileEntry.value;
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      // list.add(base64String);
      list.add({
        "inc_image":"${base64String}"
      });
    }
  // print(list);
  body["incident_uploads"]=list;
  var request_bdy=jsonEncode(body);
    body.addAll(fileMap);
    var logger = Logger();
    logger.d("test data before upload ${ body["incident_uploads"]}");
    var response = await _http.post("${Api.getIncidentSave}",
        jsonEncode(body),
        contentType: true
    );
    return jsonDecode(response.toString());
  }

  getDivisionList() async {
    var response = await _http.get("${Api.getDivisionList}");
    debugPrint("get getDivisionList");
    return jsonDecode(response);
  }
  getEmployeeList() async {
    var response = await _http.get("${Api.getEmployeeList}");
    debugPrint("get getEmployeeList");
    return jsonDecode(response);
  }

  getSGHVehicleList() async {
    var response = await _http.get("${Api.getSGHVehicleList}");
    debugPrint("get getSGHVehicleList");
    return jsonDecode(response);
  }
  getCorrectiveActionList() async {
    var response = await _http.get("${Api.getCorrectiveActionList}");
    debugPrint("get getCorrectiveActionList");
    return jsonDecode(response);
  }
  getPreventiveActionList() async {
    var response = await _http.get("${Api.getPreventiveActionList}");
    debugPrint("get getPreventiveActionList");
    return jsonDecode(response);
  }
  getPreparedByList() async {
    var response = await _http.get("${Api.getpreparedBy}");
    debugPrint("get getPreventiveActionList");
    return jsonDecode(response);
  }
  gettStatusList() async {
    var response = await _http.get("${Api.getStatus}");
    debugPrint("get gettStatusList");
    return jsonDecode(response);
  }
  getReportByList() async {
    var response = await _http.get("${Api.getReportBy}");
    debugPrint("get getReportByList");
    return jsonDecode(response);
  }
  getIncidentViewList({required String Id})async {
    var response = await _http.get("${Api.getIncidentView}?id=$Id",auth: true);
    debugPrint("EDIT VIEW");
    return jsonDecode(response);
  }
  UpdateIncidentApproval({required dynamic body}) async {
    debugPrint("test data before upload ");

    var response = await _http.post("${Api.incidentApproveSection}",body,auth: true,contentType: true);

    return jsonDecode(response.toString());
  }
  setDataForApprovals({required dynamic body}) async {
    debugPrint("test data before upload ");

    var response = await _http.post("${Api.getDataForApprovalsInsident}",body,auth: true,contentType: true);

    return jsonDecode(response.toString());
  }
}

