
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/ui/screens/demo/sagawa_login.dart';

import '../../../controllers/controller.dart';
import '../../themes/MyColors.dart';
import '../splash/splash.dart';
import 'dashboard.dart';


class InitialLoginTest extends StatefulWidget {
  const InitialLoginTest({Key? key}) : super(key: key);

  @override
  _InitialLoginTestState createState() => _InitialLoginTestState();
}

class _InitialLoginTestState extends State<InitialLoginTest> {


  String? loggedIn;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        key: _scaffoldkey,
          body: Stack(
            children: [


              GetBuilder<AuthController>(
                  init: AuthController(),
                  initState: (state) async {
                    // IndexController.to.currentLocation();

                    bool res = await AuthController.to.loginCheck();
                    print("token value $res");
                    bool onBoarding = await AuthController.to.checkOnBoarding();
                    if ( onBoarding==true) {
                      setState(() {
                        loggedIn = "onBoarding";
                      });
                    }
                    else if (res == true) {
                      setState(() {
                        loggedIn = "loggedIn";
                      });
                    }
                    else{
                    }
                    print("logged in $loggedIn");
                  },
                  builder: (controller) =>

                  loggedIn == "onBoarding"?
                  Container(
                      color: AppColors.backgroundColor,
                      child:OnBoardingPage()
                  ) :
                  loggedIn == "loggedIn" ?
                  MyDasboardScreen():
                  SagawaLogin()
              ),
            ],
          )
      );
  }
}