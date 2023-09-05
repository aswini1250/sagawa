
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:logger/logger.dart';
import 'package:sofproject/app/controllers/VehicleAccidentController.dart';
import 'package:sofproject/app/controllers/property_damage_controller.dart';
import 'package:sofproject/app/controllers/property_damage_controller.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';


class PropertyDamageRepository{
  static final HttpHelper _http = HttpHelper();


  getDashboard({required String body}) async {
    var response = await _http.get("${Api.getPropertyDamageDashboard}$body");
    return jsonDecode(response);
  }
  saveIncident({required body}) async {
    var list=[];
    Map<String, MultipartFile> fileMap = {};
    Map<String, File> getFile= {};
    for(int i=0;i< PropertyDamageController.to.selectedFiles.length;i++){
      getFile.addAll({
        "$i": PropertyDamageController.to.selectedFiles[i]
      });
    }
    for (MapEntry fileEntry in getFile.entries) {
      File file = fileEntry.value;
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      // list.add(base64String);
      list.add({
        "prt_image":"${base64String}"
      });
    }
    print(list);
    body["damage_uploads"]=list;
    var request_bdy=jsonEncode(body);
    body.addAll(fileMap);
    var logger = Logger();
    logger.d("test data before upload ${ body["incident_uploads"]}");
    debugPrint("test data before upload $request_bdy");
    var response = await _http.post("${Api.getPropertySave}",
        jsonEncode(body),
        contentType: true
    );
    return jsonDecode(response.toString());
  }

  getDivisionList() async {
    var response = await _http.get("${Api.getDivisionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }

  getEmployeeList() async {
    var response = await _http.get("${Api.getEmployeeList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getCreaterNameList() async {
    var response = await _http.get("${Api.getCorrectiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getEditorNameList() async {
    var response = await _http.get("${Api.getPreventiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }

  getSGHVehicleList() async {
    var response = await _http.get("${Api.getSGHVehicleList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getCorrectiveActionList() async {
    var response = await _http.get("${Api.getCorrectiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getPreventiveActionList() async {
    var response = await _http.get("${Api.getPreventiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getPreparedByList() async {
    var response = await _http.get("${Api.getpreparedByPro}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  gettStatusList() async {
    var response = await _http.get("${Api.getStatusPro}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getReportByList() async {
    var response = await _http.get("${Api.getReportByPro}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getIncidentViewList({required String Id})async {
    var response = await _http.get("${Api.getPropertyView}?id=$Id",auth: true);
    debugPrint("EDIT VIEW");
    return jsonDecode(response);
  }
  UpdateIncidentApproval({required dynamic body}) async {
    debugPrint("test data before upload ");

    var response = await _http.post("${Api.propertyApproveSection}",body,auth: true,contentType: true);

    return jsonDecode(response.toString());
  }
  setDataForApprovals({required dynamic body}) async {
    debugPrint("test data before upload ");

    var response = await _http.post("${Api.getDataForApprovalsProperty}",body,auth: true,contentType: true);

    return jsonDecode(response.toString());
  }

}