
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';

import '../../../controllers/incident_controller.dart';


class IncidentFormRepository{
  static final HttpHelper _http = HttpHelper();


  getDashboard() async {
    var response = await _http.get("${Api.getIncidentDashboard}");
    return jsonDecode(response);
  }
  saveIncident({required body}) async {
    var list=[];
    Map<String, MultipartFile> fileMap = {};
    Map<String, File> getFile= {};
    IncidentController.to.selectedFiles.forEach((File e){
      getFile.addAll({
        "incident_uploads": e
      });
    });
    for (MapEntry fileEntry in getFile.entries) {
      File file = fileEntry.value;
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      // list.add(base64String);
      list.add({
        "inc_image":"${base64String}"
      });
    }
    body["incident_uploads"]=list;
    body.addAll(fileMap);
    debugPrint("test data before upload $body");
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
    var response = await _http.get("${Api.getSGHVehicleList}");
    debugPrint("get getPreventiveActionList");
    return jsonDecode(response);
  }
  gettStatusList() async {
    var response = await _http.get("${Api.getCorrectiveActionList}");
    debugPrint("get gettStatusList");
    return jsonDecode(response);
  }
  getReportByList() async {
    var response = await _http.get("${Api.getPreventiveActionList}");
    debugPrint("get getReportByList");
    return jsonDecode(response);
  }
}