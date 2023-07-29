import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/color.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
                          color: opBackgroundColor,
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
                    Text(
                      "aswini",
                      style: TextStyle(
                        color: sidemenucolor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "aswini",
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                    Text(
                      "aswini",
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                    SizedBox(height: 30.0),
                    _buildDivider(),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.home,
                        color: sidemenucolor,
                        size: 20,
                      ),
                      title: Text('home'.tr,
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
                              color: sidemenucolor,
                              size: 20,
                            ),
                            title: Text('Incident Management'.tr,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          )),
                      children: <Widget>[
                        ExpansionTile(
                          tilePadding: const EdgeInsets.only(left: 18.0),
                          iconColor: primary,
                          collapsedTextColor: Color(0xFFf9e9ce),
                          textColor: primary,
                          backgroundColor: Color(0xFFf9e9ce),
                          collapsedIconColor: Color(0xFFf9e9ce),
                          title: Text(
                            "incident".tr,
                            style: TextStyle(
                              //color:Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ExpansionTile(
                              tilePadding:
                              const EdgeInsets.only(right: 20.0, left: 20),

                              initiallyExpanded: true,
                              title: InkWell(
                                child: Text("Accident".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF686868))),
                                onTap: () {


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
                                      'Primary damage'.tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF686868))),
                                  onTap: () async {
                                    // pr.show();

                                    print('clicked custom category');
                                    //print(categorylist[index].catName);
                                    //print(categorylist[index].catId);

                                    Future.delayed(Duration(seconds: 2))
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }),
                              onExpansionChanged: ((newState) {}),
                            ),
                          ],
                        ),
                      ],
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
                        color: sidemenucolor,
                        size: 20,
                      ),
                      title: Text('logout'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    _buildDivider(),
                    // ListTile(
                    //   onTap: () {},
                    //   leading: Icon(
                    //     Icons.group_add,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    //   title: Text('Geneology',
                    //       style: TextStyle(fontSize: 14, color: Colors.white)),
                    // ),
                    // _buildDivider(),
                    // ListTile(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   leading: Icon(
                    //     Icons.add_circle_outlined,
                    //     color: Colors.white,
                    //     size: 20,
                    //   ),
                    //   title: Text('More !!',
                    //       style: TextStyle(fontSize: 14, color: Colors.white)),
                    // ),
                    // _buildDivider(),
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
