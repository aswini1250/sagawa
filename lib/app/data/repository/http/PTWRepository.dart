import 'dart:convert';

import 'package:get/get.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';

  class PTWRepository{
  static final HttpHelper httpHelper = HttpHelper();
  Future<dynamic> getList() async {
  var response = await httpHelper.get("${Api.getList}",
  auth: true);
  print("getList $response");
  return jsonDecode(response);
  }
}