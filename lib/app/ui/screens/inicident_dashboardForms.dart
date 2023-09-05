
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/controllers/DashboardController.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/utils/common_drop_down_TRL.dart';
import 'package:sofproject/app/ui/widgets/utils/common_label_expanded_wrap_TRL.dart';
import 'package:sofproject/app/ui/widgets/utils/common_textfield_TRL.dart';

import '../widgets/commonExpandableRadioButton.dart';
import '../widgets/utils/fade_animation_TRL.dart';

class IncidentDashboardForms extends StatefulWidget {
  IncidentDashboardForms({Key? key}) : super(key: key);

  @override
  State<IncidentDashboardForms> createState() => _IncidentDashboardFormsState();
}

class _IncidentDashboardFormsState extends State<IncidentDashboardForms> {
  TextEditingController jobDescriptionController=TextEditingController();

  SingingCharacter? _character = SingingCharacter.nearMiss;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: AppColors.primaryColor,
        title: new Text(
          'Incident Form'.tr,
          style: TextStyle(color: AppColors.white),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
///radiobutton
              FadeAnimation(
                  1.4,
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              height: null,
                              margin: EdgeInsets.fromLTRB(
                                  20, 20, 20, 10),
                              padding: EdgeInsets.only(
                                  top: 25, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1),
                                borderRadius:
                                BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  children: <Widget>[   RadioListTile<SingingCharacter>(
                                    title: const Text('Lafayette'),

                                    value: SingingCharacter.nearMiss,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                    RadioListTile<SingingCharacter>(
                                      title: const Text('Thomas Jefferson'),
                                      value: SingingCharacter.customerComplaints,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ])),
                          Positioned(
                              left: 50,
                              top: 12,
                              child: Container(
                                width: 275,
                                padding: EdgeInsets.only(
                                    bottom: 10,
                                    left: 10,
                                    right: 10),
                                color: Colors.white,
                                child: Text(
                                  "Positive Isolation".tr,
                                  maxLines: 4,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              )),
                        ],
                      ))),



              ///Expandable widget with common textfield
              CommonExpandableWrap(
                  title: 'A. Subject',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Subject",
                    hintText: "Enter Subject",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),

              /// common dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CommonDropDown(
                  initialValue: "Division and Cost Centre",
                  labelText: "Division and Cost Centre",
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],
                  hintText: "Enter name",
                  title: 'name',
                  cb: (value){
                    debugPrint("Chosen value $value");
                  },
                ),
              ),
/*
              ///Expandable widget with common dropdown inside without model
              CommonExpandableWrap(
                title: 'A. Job Dropdowns',
                child: CommonDropDown(
                  initialValue: "Flutter developer",
                  labelText: "Job",
                  items: [
                    {
                      "job":"Flutter developer",
                      "id":"sdfsfs"
                    },
                    {
                      "job":"Php developer",
                      "id":"sdflmkmsfs"
                    },

                  ],
                  hintText: "Enter job",
                  title: 'job',
                  cb: (value){
                    debugPrint("Chosen value $value");
                  },
                ),
              ),*/
              ///Expandable widget with common textfield
              CommonExpandableWrap(
                  title: 'B. Customer Name',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Customer Name",
                    hintText: "Enter Customer Name",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'C. Place of Occurrence',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Place of Occurrence",
                    hintText: "Enter Place of Occurrence",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'D. Date and Time',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Date and Time",
                    hintText: "Enter Date and Time",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CommonDropDown(
                  initialValue: "Employee Name",
                  labelText: "Employee Name",
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],
                  hintText: "Enter Employee Name",
                  title: 'name',
                  cb: (value){
                    debugPrint("Chosen value $value");
                  },
                ),
              ),
              CommonExpandableWrap(
                  title: 'Staff ID',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Staff ID",
                    hintText: "Enter Staff ID",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CommonDropDown(
                  initialValue: "SGH Vehicle number",
                  labelText: "SGH Vehicle number",
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],
                  hintText: "Enter SGH Vehicle number",
                  title: 'name',
                  cb: (value){
                    debugPrint("Chosen value $value");
                  },
                ),
              ),
              CommonExpandableWrap(
                  title: 'E. Consignee / shipper',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Consignee / shipper",
                    hintText: "Enter Consignee / shipper",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'F. MAWB',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "MAWB",
                    hintText: "Enter MAWB",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'G. HAWB',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "HAWB",
                    hintText: "Enter HAWB",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'H. Total Quantity of Item',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Total Quantity of Item",
                    hintText: "Enter Total Quantity of Item",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'I. Weight',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Weight",
                    hintText: "Enter Weight",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'J. Quantity of Damaged',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Quantity of Damaged",
                    hintText: "Enter Quantity of Damaged",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
              CommonExpandableWrap(
                  title: 'K. Remarks',
                  child:CommonTextField(
                    controller:jobDescriptionController,
                    labelText: "Remarks",
                    hintText: "Enter Remarks",
                    onChange: (data){

                    },
                    validator: (data){
                      return null;
                    },
                  )
              ),
SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonButton(title: "Cancel", onTap: (){


                    }),
          commonButton(title: "Submit", onTap: (){
            Get.to(()=> RadioListTileApp());

          })

          ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
