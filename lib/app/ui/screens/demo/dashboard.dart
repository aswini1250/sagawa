import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/controllers/DashboardController.dart';
import 'package:sofproject/app/ui/screens/demo/PrimaryDamageScreen.dart';
import 'package:sofproject/app/ui/screens/demo/drawer.dart';
import 'package:sofproject/app/ui/screens/demo_listview_gridview_checkbox.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/color.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';

import 'AccidentScreen.dart';
import 'IncidentScreenDashboard.dart';

class MyDasboardScreen extends StatefulWidget {
   MyDasboardScreen({Key? key}) : super(key: key);



  @override
  State<MyDasboardScreen> createState() => _MyDasboardScreenState();
}

class _MyDasboardScreenState extends State<MyDasboardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(

          "assets/images/splashscreen.webp",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          color: AppColors.white,
        ),
        Scaffold(
           key: _key,
          resizeToAvoidBottomInset : false,
          drawer: DrawerMenu(),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _key.currentState!.openDrawer();
              },
            ),
            titleSpacing: 0.0,
            elevation: 0.5,
            backgroundColor:  AppColors.primaryColor,
            title: Text(
              'Sawaga'.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,fontFamily: "Sakkal Majalla",
                  fontSize: 20.0),
              textAlign: TextAlign.left,
            ),
            // actions: <Widget>[_buildAvatar(context)],
            actions: <Widget>[
              InkWell(
                onTap: () {

                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: notification(),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              InkWell(
                onTap: () {
                  debugPrint("individual ");
                  showDeleteAlertDialog(
                      Get.context!,
                      Id: "");
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Stack(
                      children: <Widget>[
                        new Icon(Icons.power_settings_new, color: Colors.white, size: 28),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body:
          Column(children: <Widget>[
            InkWell(onTap:(){
              showBottomDialogRisk(context);
            },
                child: gridviewPart())

        ]),
        )  ],
    );
  }

  Stack notification() {
    return Stack(
                    children: <Widget>[
                      new Icon(Icons.notifications, color: Colors.white, size: 28),
                      new Positioned(
                        right: 0,
                        child: new Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: rejectbg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: new Text(
                            "1",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  );
  }

  void showBottomDialogRisk(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height/1.7 ,
            child:AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),

              title:OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                // padding: const EdgeInsets.all(0.0),
                onPressed: () {  },
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppColors.primaryColor,
                        AppColors.primaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,

                    child: Text(
                      'Incident Management'.tr,
                      style: TextStyle(fontFamily: "Sakkal Majalla",color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              content:
              SingleChildScrollView(
                child:

                   Column(
                    children: <Widget>[
/////////////////////////////////////////////////////////
                      shortWithoutArrowExtensibleWidget(text: 'Incident', onTap: (){Get.to(    IncidentScreenDashboard(),
                      );},),
                      shortWithoutArrowExtensibleWidget(text: 'Accident',  onTap: (){Get.to(    AccidentScreen(),
                      );},),
                      shortWithoutArrowExtensibleWidget(text: 'Primary damage',  onTap: (){Get.to(    PrimaryDamageScreen(),
                      );},),


                    ],
                  ),

              ),
              actions: <Widget>[
                SizedBox(width: 20,),

commonButton(title: "Cancel", onTap: (){})  ,
                SizedBox(width: 20,),


              ],
            ) ,

            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }//

  showDeleteAlertDialog(BuildContext context, {required String Id}) {
    // set up the buttons
    Widget cancelButton = commonButton(

      title: "Cancel",onTap: (){

    },
    );
    Widget continueButton =   commonButton(
      title: "Confirm",onTap: (){},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text(
        "Alert!".tr,
        style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Are you sure you want to logout?".tr,
        style: TextStyle(color: AppColors.black, fontSize: 15),
      ),
      actions: [
        Row(
          children: [
            cancelButton,
            SizedBox(width: 20),
            continueButton,

          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  GridView gridviewPart() {
    return GridView.builder(
        padding: EdgeInsets.only(top: 10),

        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: .9/ 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 4),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            decoration: BoxDecoration(color: AppColors.white,
                boxShadow: commonBoxShadow(),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                    height: 100,
                    width: 150,
                    child: Image.asset('assets/images/incident.png',height: 50,color: AppColors.primaryColor,fit: BoxFit.fill,)),
                SizedBox(height: 30,),
                Text("Incident Management",style: TextStyle(color: AppColors.black,fontSize: 15),),
              ],
            ),
          );
        });
  }
  Widget shortWithoutArrowExtensibleWidget({required String text,required Function() onTap}){
    return                     ExpansionTile(
      tilePadding: const EdgeInsets.only(right: 20.0, left: 20),
      initiallyExpanded: true,
      trailing: Image.asset(
        "assets/images/files.png",
        color: primary,
        width: 24,
        height: 24,
      ),
      title: InkWell(
        child: Text(
          "$text",
          style: TextStyle(
              color: Color(0xFF686868),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {
          onTap();
        },
      ),
    );

  }

}
List<BoxShadow> commonBoxShadow() {
  return [
    BoxShadow(
        color: Colors.grey.withAlpha(70),
        offset: const Offset(1.0, 1.0),
        blurRadius: 3,
        spreadRadius: 2)
  ];
}

