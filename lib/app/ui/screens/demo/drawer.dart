import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sofproject/app/ui/screens/demo/IncidentScreenDashboard.dart';
import 'package:sofproject/app/ui/screens/demo/VehicleAccidentScreenDashboard.dart';
import 'package:sofproject/app/ui/screens/demo/property_damage.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/controller.dart';



class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenu createState() => _DrawerMenu();
}

class _DrawerMenu extends State<DrawerMenu> {


  @override
  void initState() {
    //insertApi();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ClipPath(

        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                    AppColors.primaryColor,
                  ],
                ),
                color: Color(0xFF404040),
                boxShadow: [BoxShadow(color: primary)]),
            width: 200,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          debugPrint("individual ");
                          showDeleteAlertDialog(
                              Get.context!,
                              Id: "");                                 },
                      ),
                    ),
                    CircleAvatar(
                      radius: 85,
                      backgroundColor: Color(0xFFefeff4),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo-img-sofproject.png',
                          width: 250,
                          height: 350,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

                    SizedBox(height: 5.0),
                    // Text(
                    //   "aswini",
                    //   style: TextStyle(
                    //     color: AppColors.white,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // Text(
                    //   "aswini",
                    //   style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    // ),
                    // Text(
                    //   "aswini",
                    //   style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    // ),
                    SizedBox(height: 30.0),
                    _buildDivider(),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.home,
                        color: AppColors.white,
                        size: 20,
                      ),
                      title: Text('Home'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    _buildDivider(),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0.0),
                      iconColor: Color(0xFFf9e9ce),
                      collapsedIconColor: Color(0xFFf9e9ce),
                      title: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 36.0),
                          // min sizes for Material buttons
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.assignment_late_outlined,
                              color: AppColors.white,
                              size: 20,
                            ),
                            title: Text('Incident Management'.tr,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          )),
                      children: <Widget>[
                        ExpansionTile(
                          tilePadding:
                          const EdgeInsets.only(right: 20.0, left: 20),

                          initiallyExpanded: true,
                          title: InkWell(
                            child: Text("Incident".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color:AppColors.white)),
                            onTap: () {
Get.to(()=>IncidentScreenDashboard());

                            },
                          ),
                          onExpansionChanged: ((newState) {

                          }),
                        ), //

                        ExpansionTile(
                          tilePadding:
                          const EdgeInsets.only(right: 20.0, left: 20),

                          initiallyExpanded: true,
                          title: InkWell(
                            child: Text("Accident".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.white)),
                            onTap: () {

                              Get.to(()=>VehicleAccidentScreenDashboard());

                            },
                          ),
                          onExpansionChanged: ((newState) {

                          }),
                        ), //
                        ExpansionTile(
                          tilePadding:
                          const EdgeInsets.only(right: 20.0, left: 20),

                          initiallyExpanded: true,
                          title: InkWell(
                              child: Text(
                                  'Property damage'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.white)),
                              onTap: () async {
                                Get.to(()=>PropertyDamageScreenDashboard());

                              }),
                          onExpansionChanged: ((newState) {}),
                        ),                      ],
                    ),
                    _buildDivider(),
                    ListTile(
                      onTap: () {
                        debugPrint("individual ");
                        showDeleteAlertDialog(
                            Get.context!,
                            Id: "");                      },
                      leading: Icon(
                        Icons.power_settings_new,
                        color: AppColors.white,
                        size: 20,
                      ),
                      title: Text('Logout'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    _buildDivider(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.white,
    );
  }
}
showDeleteAlertDialog(BuildContext context, {required String Id}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel".tr,
      style: TextStyle(color: AppColors.primaryColor),
    ),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    child:
    Text("Confirm".tr, style: TextStyle(color: AppColors.primaryColor)),
    onPressed: () async {
      AuthController.to.logout();

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Alert!".tr,
      style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Are you sure you want to logout?".tr,
      style: TextStyle(color: AppColors.primaryColor, fontSize: 15),
    ),
    actions: [
      cancelButton,
      continueButton,
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
