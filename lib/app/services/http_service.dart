
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../exceptions/app_exception.dart';

class HttpHelper {

  Future<Response> multipart(
      String url, Map<String, dynamic> data, Map<String, File> files,
      {bool isImageUpload = false, auth = false}) async {
    print("Api Post url $url");

    Map<String, MultipartFile> fileMap = {};
    if (isImageUpload == true) {
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = file.path;
        fileMap[fileEntry.key] = MultipartFile(
            file.openRead(), await file.length(),
            filename: fileName);
      }
      print("check imageupload ${data.runtimeType}");
      data.addAll(fileMap);
    }
    var formData = FormData.fromMap(data);
    Dio dio = Dio();
    Map<String, dynamic> headers = {};
    if (auth == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      if (token != null && token.isNotEmpty) {
        headers.addAll(
          {
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.acceptHeader: "application/json",
            //'X-API-Key':"${AppConfig.appSignatureKey}"
          },
        );
      }
    }
    return await dio.post(
      url,
      data: formData,
      options: auth == true
          ? Options(contentType: 'multipart/form-data', headers: headers)
          : Options(
          contentType: 'multipart/form-data',
          followRedirects: false,
          validateStatus: (status) => true),
    );
  }



  Future<dynamic> get(String url, {bool auth = false}) async {

    Map<String, String> hd = await getHeaders(auth);

    print("Api URL:$url header:$hd");
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: hd);
      print("test response : $response code :${response.statusCode}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection',500);
    }
    return responseJson;
  }
  Future<dynamic> post(String url,dynamic body ,{bool auth = false,bool contentType=false}) async {
    Map<String, String> hd = await getHeaders(auth,contentType:contentType);

    print("Api URL:$url header:$hd");
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body:body,headers: hd);
      print("test response : ${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection',500);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {bool auth = false, bool contentType = false}) async {
    Map<String, String> hd = await getHeaders(auth, contentType: contentType);

    debugPrint('Api Post, url $url body : $body header :$hd');
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body, headers: hd);
      debugPrint("api response before decode  ${"$response"}");

      responseJson = _returnResponse(response);
      debugPrint("api response ${"$responseJson"}");
      // Utility.log(responseJson);
    } on SocketException {
      // Utility.log('No net');
      throw FetchDataException('No Internet connection', 500);
    }
    // Utility.log('api post.');
    return responseJson;
  }
  Future<dynamic> delete(String url, dynamic body,
      {bool auth = false, bool contentType = false}) async {
    Map<String, String> hd = await getHeaders(auth, contentType: contentType);

    debugPrint('Api Post, url $url body : $body header :$hd');
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), body: body, headers: hd);
      debugPrint("api response before decode  ${"$response"}");

      responseJson = _returnResponse(response);
      debugPrint("api response ${"$responseJson"}");
      // Utility.log(responseJson);
    } on SocketException {
      // Utility.log('No net');
      throw FetchDataException('No Internet connection', 500);
    }
    // Utility.log('api post.');
    return responseJson;
  }


  getHeaders(auth,{bool contentType=false}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String location='';
    location=prefs.getString("location")??"";
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      "location":"$location",
      //'X-API-Key':AppConfig.appSignatureKey,

      // "Access-Control-Allow-Origin": "*"
    };
    if(contentType==true) {
      headers.addAll({
        HttpHeaders.contentTypeHeader:"application/json",
      });
    }
    else{
      headers.addAll({
        HttpHeaders.acceptHeader:"application/json",
      });
    }
      var token=prefs.getString("token");
      if(token!=null && token.isNotEmpty){
        headers.addAll({
          HttpHeaders.authorizationHeader: "Bearer $token",
        });
      }
      return headers;
    }
  }




  dynamic _returnResponse(http.Response response) async {
  if(response.statusCode==500 || response.statusCode==502){
    throw FetchDataException('',500);
  }
    // var responseBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.body;
        return responseJson;
      case 400:
        var responseJson = response.body;
        return responseJson;
      case 404:
        var message = "";
        //throw BadRequestException(message.toString(), response.statusCode);
     var responseJson = response.body;
      return responseJson;
      case 401:
      case 403:
        //Utility.log('object');

        throw UnauthorisedException( "", response.statusCode,
            next: "");

        break;
      case 422:
        var responseJson = response.body.toString();
        return responseJson;
      case 502:
        throw FetchDataException('',500);
      case 500:
      throw FetchDataException('${json.decode(response.body)['message']}',500);
      default:
        throw FetchDataException('${json.decode(response.body)['message']}',500);
    }
  }


