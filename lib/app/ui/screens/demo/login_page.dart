//Packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/ui/screens/demo/dashboard.dart';

import '../../../controllers/controller.dart';
import '../../../services/responsive_service/responsive.dart';
import '../../themes/MyColors.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textform_field.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/text_button.dart';
import '../demo_listview_gridview_checkbox.dart';

class LoginPage extends StatelessWidget {
  final int? login;
  LoginPage({Key? key, this.login}) : super(key: key);
  final loginFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _loginScaffoldKey = GlobalKey<ScaffoldState>();
  String LanguagesValue = 'Select Language';
  List<String> Languages = [
    'Select Language',
    'English',
    'Arabic',
  ];
  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  @override
  Widget build(BuildContext context) {
    // AuthController.to.loginInit();
    // AuthController.to.listCountryCodes();
    return Scaffold(
      key: _loginScaffoldKey,
      //  resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (data) => SingleChildScrollView(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      loginImage(),
                      bottomWidget(context),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget loginImage() {
    return Container(
      height: Get.height*.4,
//width: Get.width,

      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: CommonBoxShadow()),
      child: Center(
          child: Image.asset(
        "assets/images/logo-img-sofproject.png",
        height: 200,
        width: Get.width * .9,
        fit: BoxFit.fitWidth,
      )),
    );
  }

  Widget bottomWidget(context) {
    final Widget? child;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      child: Container(
        width: kIsWeb
            ? responsiveScreen(context: context) == WebScreenType.Mobile
                ? Get.width
                : responsiveScreen(context: context) == WebScreenType.Tab
                    ? Get.width * 0.4
                    : Get.width * 0.3
            : Get.width,
        decoration: BoxDecoration(
            color: AppColors.white,
            // boxShadow: commonBoxShadow(),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Center(
            child: Column(
              children: [
                Text("Sign In to start your session",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      CommonTextFormField(
                        controller: AuthController.to.username,
                        hintText: "Email/Phone",
                        lableText: "Email/Phone",
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? data) {
                          // print("test data $data");
                          final bool isValid =
                              GetUtils.isEmail(data.toString().trimRight());
                          if (data == "" || data == null) {
                            print("test invalid email");
                            return "Please enter a  email or phone number.";
                          } else if (isValid == false && !isPhone(data)) {
                            return 'Please enter a valid email or phone number.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CommonTextFormField(
                        controller: AuthController.to.password,
                        password: true,
                        hintText: "Enter Your Password",
                        lableText: "Password",
                        maxlines: 1,
                        validator: (data) {
                          if (data == "" || data == null) {
                            return "Please enter password";
                          } else if (data.toString().length <= 7) {
                            return "Password must be 8 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 15,
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => AuthController.to.updateLoginLoading == true
                          ? Container(
                              height: 60, width: 60, child: ProgressLoading())
                          : commonButton(
                              title: "Sign In".tr,
                              onTap: () {
                                print(
                                    "test ${loginFormKey.currentState!.validate()}");
                                if (loginFormKey.currentState!.validate()) {
                                  AuthController.to.updatelogin();
                                  Get.to(() =>
                                  MyDasboardScreen()
                                    //  HomeScreen()
                                  );
                                }
                              },
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<BoxShadow> CommonBoxShadow() {
  return [
    BoxShadow(
      color: AppColors.grey.withAlpha(70),
      offset: Offset(1.5, 1.5),
      blurRadius: 170,
      spreadRadius: 2,
    )
  ];
}

Widget listPart() {
  return Container(
    height: Get.height,
    width: Get.width,
    margin: EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(color: Colors.orange),
    child: ListView.builder(
      itemCount: AuthController.to.nameList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${AuthController.to.nameList[index]['username']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['password']}",
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['personalDetails']}",
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['phonenumber']}",
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['dateOfBirth']}",
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['gender']}",
                  ),
                  Text(
                    "${AuthController.to.nameList[index]['location']}",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Expanded emptyPart() {
  return Expanded(
      child: Center(
    child: Text(
      "No names added yet!",
      style: TextStyle(color: Colors.grey),
    ),
  ));
}

Expanded loadingPart() {
  return Expanded(
      child: Center(
          child: CircularProgressIndicator(
    color: AppColors.primaryColor,
  )));
}
