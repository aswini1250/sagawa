
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofproject/app/controllers/DashboardController.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

class IncidentDashboardMyForms extends StatefulWidget {
  IncidentDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<IncidentDashboardMyForms> createState() => _IncidentDashboardMyFormsState();
}

class _IncidentDashboardMyFormsState extends State<IncidentDashboardMyForms> {
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
                                    title: const Text('Near Miss '),
                                    activeColor: AppColors.primaryColor,
                                    value: SingingCharacter.nearMiss,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                    RadioListTile<SingingCharacter>(
                                      title: const Text('Customer Complaints '),
                                      value: SingingCharacter.customerComplaints,
                                      groupValue: _character,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                    RadioListTile<SingingCharacter>(
                                      title: const Text('General Incidents'),
                                      value: SingingCharacter.generalIncident,
                                      groupValue: _character,
                                      activeColor: AppColors.primaryColor,
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
                                  "Incident Categories:".tr,
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
              Container(
             width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.subject,
                  lableText: "Subject",
                  hintText: "Enter Subject",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              /// common dropdown
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'name',
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],                label: 'Division and Cost Centre'.tr,

                  isRequired: true,
                  controller:DashboardController.to.divisorCostCentre,
                  onChanged: (data) {
                  }, cb: (){},
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
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.customerName,
                  lableText: "Customer Name",
                  hintText: "Enter Customer Name",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),


              ///Expandable widget with common textfield

              /// common dropdown
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'name',
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],                label: 'Place of Occurrence'.tr,

                  isRequired: true,
                  controller: DashboardController.to.placeOfOccurance,
                  onChanged: (data) {
                  }, cb: (){},
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
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.dateAndTime,
                  isDatePicker:true,

                  lableText: "Date and Time",
                  onTap: ()async{
                    print("test tap");
                    DateTime? datepicked = await showDatePicker(
                        context: Get.context!,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());
                    if (datepicked != null) {
                      DashboardController.to.dateAndTime.text = DateFormat('MM/d/yyyy - hh:mm a').format(datepicked);
                    }
                  },
                  hintText: "Enter Date and Time",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              /// common dropdown
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'name',
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],                label: 'Employee Name'.tr,

                  isRequired: true,
                  controller: DashboardController.to.employeeName,
                  onChanged: (data) {
                  }, cb: (){},
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
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.staffId,
                  lableText: "Staff ID",
                  hintText: "Enter Staff ID",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              /// common dropdown
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
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'name',
                  items: [
                    {
                      "name":"Aravind",
                      "id":"sdfsfs"
                    },
                    {
                      "name":"Aswini",
                      "id":"sdflmkmsfs"
                    },

                  ],                label: 'SGH Vehicle number'.tr,

                  isRequired: true,
                  controller: DashboardController.to.sghVehicleNumber,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),

              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.consigneeShipper,
                  lableText: "Consignee / shipper",
                  hintText: "Consignee / shipper",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.mawb,
                  lableText: "MAWB",
                  hintText: "MAWB",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.hawb,
                  lableText: "HAWB",
                  hintText: "HAWB",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.totalQuantityOfItem,
                  lableText: "Total Quantity of Item",
                  hintText: "Total Quantity of Item",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.weight,
                  lableText: "Weight",
                  hintText: "Weight",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.quantityOfDamaged,
                  lableText: "Quantity of Damged",
                  hintText: "Quantity of Damged",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.remarks,
                  lableText: "Remarks",
                  hintText: "Remarks",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.correctionAction,
                  lableText: "Corrective Action",
                  hintText: "Corrective Action",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.preventiveAction,
                  lableText: "Preventive Action",
                  hintText: "Preventive Action",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:DashboardController.to.rootCauseAnalysis,
                  lableText: "Root Cause Analysis",
                  hintText: "Root Cause Analysis",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),


              /// common dropdown
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
