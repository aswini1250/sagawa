/*
import 'dart:convert';

import 'package:complete_api/app/data/models/photo_model/photo_model.dart';
import 'package:complete_api/app/data/repository/contract/authcontracat.dart';
import 'package:complete_api/app/services/api_service.dart';
import 'package:complete_api/app/services/http_service.dart';

class FakeUserRepository extends AuthContract{
  static final HttpHelper _httpHelper = HttpHelper();
  @override
  Future<UserList> fetchUserList(pageIndex) async{
    var response = await _httpHelper.get(Api.baseapi);
    UserList _userList = UserList.fromJson(jsonDecode(response));
    return _userList;
  }

}*/
