import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;
import 'package:sofproject/app/ui/themes/MyColors.dart';

import '../../widgets/progress_dialog.dart';
import 'dashboard.dart';
import 'forgot_password_page.dart';

class SagawaLogin extends StatefulWidget {
  const SagawaLogin({Key? key}) : super(key: key);

  @override
  State<SagawaLogin> createState() => _SagawaLoginState();
}

bool PasswordVisible = true;
bool RememberMe = true;

// bool isloginstatus1 = true;
// bool isloginstatus2 = true;

class _SagawaLoginState extends State<SagawaLogin> {
  ProgressDialog? pr;
  String _r_loginname = "";
  String full_name = "";
  String _r_password = "";
  final _formKey = GlobalKey<FormState>();
  String Selected_Designation = "";

  // String User_Name= '';

// bool Login = isloginstatus1 || isloginstatus2;
//
//   @override
//   LoginScreen4(String username, String fullname, String password_2,
//       String role_id) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // String fb_token=(prefs.getString('firebasetoken') ?? "");
//
//     print("username"+username);
//     print("password_2"+password_2);
//     final String apiEndpoint = Api.base_url + Api.Login_Request_withFB;
//     final Uri url = Uri.parse(apiEndpoint);
//     print(apiEndpoint);
//     Map data1 = {
//       "username": username,
//       "userpass": password_2,
//     };
//     var body = json.encode(data1);
//     final res = await http.post(url, headers: {"Content-Type": "application/json"},body:body);
//     print(res.body);
//     final data = jsonDecode(res.body);
//     print(data);
//     if (data ["loginstatus"].toString().toLowerCase() == "1")
//     {
//       final String apiEndpoint = Api.base_url + Api.Login_Request_withFB;
//       final Uri url = Uri.parse(apiEndpoint);
//       print(apiEndpoint);
//       // final String apiEndpoint1 = Api.base_url + Api.Request_AccessToken;
//       // final Uri url1 = Uri.parse(apiEndpoint1 + "?username=" + username);
//       // print(url1);
//
//       prefs.setString("user_id", data["id"].toString());
//       prefs.setString("username", data["username"].toString());
//       prefs.setString("role_id", data["role_id"].toString());
//       prefs.setString("full_name", data["full_name"].toString());
//       print(data["reporterdetails"]["rdesignation"].toString());
//       prefs.setString("reporterdetails", data["reporterdetails"]["rdesignation"].toString());
//       Navigator.push(context, PageTransition(
//           child: DashboardTRLPage(ReportCase_ID: true),
//           type: PageTransitionType.leftToRight));
//     }
//     else
//     {
//       String err_msg = "Try Again";
//       setState(() {
//         pr.hide().whenComplete(() {
//           print(pr.isShowing());
//         });
//       });
//       showDialog(
//           context: context,
//           builder: (c) {
//             return AlertDialog(
//               title: Text("Notification"),
//               content: Text(err_msg),
//               actions: [
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text("Close"))
//               ],
//             );
//           });
//     }
//     // if(data){
//     //   setState(() {
//     //     Navigator.of(context).pop();
//     //     Navigator.push(context, PageTransition(child: DashboardTRLPage(ReportCase_ID: true), type: PageTransitionType.leftToRight));
//     //   });
//     // }
//
//
//
//   }


  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery
        .of(context)
        .padding;
    Size size = MediaQuery
        .of(context)
        .size;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    pr = new ProgressDialog(context);
    pr!.style(
      message: 'Valid Requst',
      borderRadius: 6.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 6.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 6.0, fontWeight: FontWeight.w600),
      messageTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0),
    );
    return Scaffold(
      backgroundColor:  AppColors.primaryColor,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          height: size.height * 0.7,
          width: size.width * 1,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(

                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120)
              ),
              boxShadow: const [
                BoxShadow(color: Color(0xffff0100), spreadRadius: 2),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade100, Colors.grey.shade200])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo-img-sofproject.png',
                    height: 200, width: 200),
                const SizedBox(
                  height: 20,
                ),
                const Text(

                  'LOGIN',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.withOpacity(0.7)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: AppColors.primaryColor,
                        ),
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(color: Colors.black)),
                    onChanged: (value) {
                      setState(() {
                        _r_loginname = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.withOpacity(0.7)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _r_password = value;
                      });
                    },
                    obscureText: PasswordVisible,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: AppColors.primaryColor,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                PasswordVisible = !PasswordVisible;
                              });
                            },
                            icon: Icon(
                              PasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:  AppColors.primaryColor,
                            )),
                        hintText: 'Enter Your Password',
                        hintStyle: const TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, PageTransition(child: ForgetPassword_Page(), type: PageTransitionType.leftToRight));
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.06,
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    // color: const AppColors.primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // LoginScreen4(_r_loginname, _r_password,
                        //     _r_password, full_name);
                        Get.to(()=>MyDasboardScreen());
                      }

                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color:AppColors.white, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
