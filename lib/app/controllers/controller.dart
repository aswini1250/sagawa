
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/data/repository/http/login_repo.dart';
import 'package:intl/intl.dart';

import '../ui/widgets/commonToast.dart';

class AuthController extends  GetxController {

  static AuthController get to => Get.put(AuthController());

  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController personalDetails=TextEditingController();
  TextEditingController phonenumber=TextEditingController();
  TextEditingController   dateOfBirth =TextEditingController();
  TextEditingController   gender =TextEditingController();
  TextEditingController   location =TextEditingController();

  final repository=LoginRepository();
  final _loginLoading =false.obs;

  get loginLoading => _loginLoading.value;

  set loginLoading(value) {
    _loginLoading.value = value;
  }


  // }
  final _getListList=[].obs;

  get getListList => _getListList.value;

  set getListList(value) {
    _getListList.value = value;
  }
final _getListLoading=false.obs;

  get getListLoading => _getListLoading.value;

  set getListLoading(value) {
    _getListLoading.value = value;
  }
  final _getListEmpty=false.obs;

  get getListEmpty => _getListEmpty.value;

  set getListEmpty(value) {
    _getListEmpty.value = value;
  }

  final _getRefreshData=false.obs;

  get getRefreshData => _getRefreshData.value;

  set getRefreshData(value) {
    _getRefreshData.value = value;
  }


  final _choosenAllData = {}.obs;

  get choosenAllData => _choosenAllData.value;

  set choosenAllData(value) {
    _choosenAllData.value = value;
  }
  getList()async{
    ///get choosen data
    getListLoading=true;
    var response=await repository.getList();
    getListLoading=false;

    if(response['success']==true){
      debugPrint("bsdbakbs");
      if(response['data'].isNotEmpty){
        for(var i=0;i<response['data'].length;i++){
          getListList.add(
             {
              "name": "${response['data'][i]['name']}",
              "chosen": false
            }
          );
        }
        debugPrint("list after formatt${getListList}");

      }else{
        getListList=[];

        getListEmpty=false;
      }

    }



  }
  // getList()async{
  ////normal get lists
  //   getListLoading=true;
  //   var response=await repository.getList();
  //   getListLoading=false;
  //
  //   if(response['success']==true){
  //     if(response['data'].isNotEmpty){
  //       List<Map<String,dynamic>>res=[];
  //       response['data'].forEach((e){
  //         res.add(e);
  //       });
  //
  //       getListList=res;
  //       getListEmpty=true;
  //     }else{
  //       getListList=[];
  //
  //       getListEmpty=false;
  //     }
  //
  //   }
  //
  //
  //
  // }
 final  _getFinalData=false.obs;

  get getFinalData => _getFinalData.value;

  set getFinalData(value) {
    _getFinalData.value = value;
  }

  updateOnlychoosenData() async {
    ///update choosen data
    List finalList=[];
    getListList.forEach((e){
      if(e['chosen']==true){
        finalList.add(e);
      }  });
      Map  body={
        "selected_members":finalList
      };
      debugPrint("body data${body}");
     var response=await repository.updatechoosenData(body: jsonEncode(body));
if(response['success']==true){
CommonToast.show(msg: "Successfully submitted");

  }else{

}


}
final _updateLoginLoading=false.obs;

  get updateLoginLoading => _updateLoginLoading.value;

  set updateLoginLoading(value) {
    _updateLoginLoading.value = value;
  }
  final  _nameList=[].obs;

  get nameList => _nameList.value;

  set nameList(value) {
    _nameList.value= value;
  }

  final _loading=false.obs;

  get loading => _loading.value;

  set loading(value) {
    _loading.value = value;
  }
clearForm(){
  username.text="";
  password.text="";
  personalDetails.text="";
  phonenumber.text="";
  dateOfBirth.text="";
  location.text="";
}
  addNamesToList(){
    loading=true;
    nameList.add({
      "username":"${username.text}",
      "password":"${password.text}",
      "personalDetails":"${personalDetails.text}",
      "phonenumber":"${phonenumber.text}",
      "dateOfBirth":"${dateOfBirth.text}",
      "gender":"${gender.text}",
      "location":"${location.text}",
    });
    loading=false;
    print("test $nameList");

  }
  updatelogin()async {
    /// normal update api
    updateLoginLoading=true;
    debugPrint("post dat");

    Map<String,dynamic> body={
      "User_Name":"${username.text}",
    };
    debugPrint("postapi before data${body}");

    var response=await repository.updateLogin(body:jsonEncode(body));
    debugPrint("postapi data${body}");
    updateLoginLoading=false;
    if(response['STATUS']==true){
      CommonToast.show(msg: "${response['MESSAGE']}");
    }else{
      CommonToast.show(msg: "${response['MESSAGE']}");

    }

  }

}
