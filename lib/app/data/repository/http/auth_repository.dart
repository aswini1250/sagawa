
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../services/api_service.dart';
import '../../../services/http_service.dart';

class AuthRepository {
  static final HttpHelper _http = HttpHelper();


  Future<dynamic>updateLogin({required String body})async{
    debugPrint("update login");
    var response =await _http.post("${Api.updateLogin}", body,contentType: true);
    debugPrint("update login sure$response");
    return jsonDecode(response);
  }
  fcmUpdate({required dynamic body}) async {
    var response = await _http.post(Api.fcmUpdate, body,auth: true);
    debugPrint("update login$response");
    return jsonDecode(response);
  }
}