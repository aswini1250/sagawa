import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;
import 'package:sofproject/app/controllers/controller.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/utils/common_textfield_TRL.dart';

import '../../../services/FCM_service.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/common_label_expanded_wrap_TRL.dart';
import 'dashboard.dart';
import 'forgot_password_page.dart';

class SagawaLogin extends StatefulWidget {
  const SagawaLogin({Key? key}) : super(key: key);

  @override
  State<SagawaLogin> createState() => _SagawaLoginState();
}


class _SagawaLoginState extends State<SagawaLogin> {
  ProgressDialog? pr;
  final loginFormKey = GlobalKey<FormState>();
  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  @override
  void initState() {
    super.initState();
    FcmService().getFcmToken(token: 'token');
  }

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
      key: loginFormKey,
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
          color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo-img-sofproject.png',
                    height: 100, width: 200),
                const SizedBox(
                  height: 10,
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
                CommonTextField(
                  controller: AuthController.to.username,
                  labelText: "User Name",
                       hintText: "User Name",
                  onChange: (data){

                  },
    validator: (String? data) {
      if (data == "" || data == null) {
        return "Please enter user name";
      } else {     return null;
      }
      },
                ),
                CommonTextField(
                  controller: AuthController.to.password,
                  labelText: "Password",
                  hintText: "Password",
                  onChange: (data){
                  },
                  validator: (data) {
                    if (data == "" || data == null) {
                      return "Please enter password";
                    } else if (data.toString().length <= 7) {
                      return "Password must be 8 characters";
                    } else {     return null;
                    }
                  },
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
                    // GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(context, PageTransition(child: ForgetPassword_Page(), type: PageTransitionType.leftToRight));
                    //     },
                    //     child: const Text('Forgot Password?',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold, fontSize: 15)))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                                Obx(
                     () => AuthController.to.updateLoginLoading == true
                          ? Container(
                              height: 60, width: 60, child: ProgressLoading())
                          :
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
                      onPressed: ()async {
     if (loginFormKey.currentState!.validate()) {
       await AuthController.to.updatelogin();
       debugPrint("yes yes");
                                 }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color:AppColors.white, letterSpacing: 1),
                      ),
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
