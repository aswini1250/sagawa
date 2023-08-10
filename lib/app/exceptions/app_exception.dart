
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/ui/screens/demo/login_page.dart';
import 'package:sofproject/app/ui/screens/demo/sagawa_login.dart';

import '../ui/widgets/commonToast.dart';
class AppException implements Exception{
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  int code;
  String message;

  FetchDataException(this.message, this.code)
      : super(message, "") {
    print("500 entry");

    checkInternet();

  }
}

class BadRequestException extends AppException {
  int code;
  String message;

  BadRequestException(this.message, this.code)
      : super(message, "Invalid Request: ") {
    // navigator!.pushNamed('/' + code.toString());
    // String scode = code != null ? code.toString() : '404';
    // Get.to(()=>Error404(errorCode: "404",platForm: "Whoops",));
    checkInternet();
  }
}

class UnauthorisedException extends AppException {
  int code;
  String message;
  String next;
  var res;

  UnauthorisedException(this.message, this.code,{this.next=""})
      : super(message, "Unauthorised: ") {
    String scode = code != null ? code.toString() : '404';
    //navigator.pushNamed('/login');
    // Utility.log("next screen $next error $res");
    // LoginController.to.otpStatusFor.value="Login";
      Get.back();
      // userPref.token.val=null;
      Get.to(()=>SagawaLogin());
      Get.snackbar("Error", message);
      // SnackBarCommon.showSnack("Error", message);
  }
}
checkInternet()async{
  bool isConnected=await checkInternetConnectivity();
  if (isConnected) {
    CommonToast.show(msg: "Sorry for the inconvenience!");
  } else {
    CommonToast.show(msg: "No internet connection");
  }
}

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    return true; // Internet connection is available
  }
}