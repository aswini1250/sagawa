
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sofproject/app/services/api_service.dart';
import 'package:sofproject/app/services/http_service.dart';


class LoginRepository{
  static final HttpHelper httpHelper = HttpHelper();
  Future<dynamic> getList() async {
    var response = await httpHelper.get("${Api.getList}",
        auth: true);
    print("getList $response");
    return jsonDecode(response);
  }
  Future<dynamic> updatechoosenData({required String body}) async {
    var response = await httpHelper.post("${Api.updateLogin}",body,contentType: true,);
    debugPrint("updateLogin $response");
    return jsonDecode(response);
  }
  Future<dynamic>updateLogin({required String body})async{
    debugPrint("update login");

    var response =await httpHelper.post("${Api.updateLogin}", body,contentType: true);
    debugPrint("update login$response");
    return jsonDecode(response);
  }

}