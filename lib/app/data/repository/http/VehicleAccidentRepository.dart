
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';


class VehicleAccidentRepository{
  static final HttpHelper _http = HttpHelper();


  getDashboard() async {
    var response = await _http.get("${Api.getIncidentDashboard}");
    return jsonDecode(response);
  }
  saveIncident({required body}) async {
    var response = await _http.post("${Api.getIncidentSave}",body);
    return jsonDecode(response);
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
    var response = await _http.get("${Api.getSGHVehicleList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  gettStatusList() async {
    var response = await _http.get("${Api.getCorrectiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
  getReportByList() async {
    var response = await _http.get("${Api.getPreventiveActionList}");
    debugPrint("get division list");
    return jsonDecode(response);
  }
}