
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../../controllers/property_damage_controller.dart';
import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

class PropertyDamageDashboardMyForms extends StatefulWidget {
  PropertyDamageDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<PropertyDamageDashboardMyForms> createState() => _PropertyDamageDashboardMyForms();
}

class _PropertyDamageDashboardMyForms extends State<PropertyDamageDashboardMyForms> {
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
          'Property Damage Form'.tr,
          style: TextStyle(color: AppColors.white),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.subject,
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
              /// common dropdown
              Obx(()=>PropertyDamageController.to.divisionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'division_and_cost_centre',
                  items: PropertyDamageController.to.division,                label: 'Division and Cost Centre'.tr,

                  isRequired: true,
                  controller:PropertyDamageController.to.divisionCostCentre,
                  onChanged: (data) {
                  }, cb: (){

                },
                ),
              ),
              ),


              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.customerName,
                  lableText: "Customer Name",
                  hintText: "Enter Customer Name",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              /// common dropdown
              Obx(()=>PropertyDamageController.to.createrNameLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'Creator Name',
                  items:PropertyDamageController.to.creatorName,                label: 'Creator Name'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.creatorName,
                  onChanged: (data) {

                  }, cb: (){


                },
                ),
              ),
              ),
              /// common dropdown
              Obx(()=>PropertyDamageController.to.editorNameLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'Editor Name',
                  items:PropertyDamageController.to.editorNewName,                label: 'Editor Name'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.editorName,
                  onChanged: (data) {

                  }, cb: (){


                },
                ),
              ),
              ),
              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.placeOfAccurance,
                  lableText: "Place of Accurance",
                  hintText: "Enter Place of Accurance",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.dateAndTime,
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
                      PropertyDamageController.to.dateAndTime.text = DateFormat('MM/d/yyyy - hh:mm a').format(datepicked);
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
              Obx(()=>PropertyDamageController.to.employeeNameLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'employee_name',
                  items:PropertyDamageController.to.employeeNameList,                label: 'Employee Name'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.employeeName,
                  onChanged: (data) {
                    PropertyDamageController.to.staffId.text=data['employee_id'];
                    debugPrint("yjbdbfnb fmdsbcjbdsj${data['employee_id']}");
                    PropertyDamageController.to.showStaff=true;
                  }, cb: (){


                },
                ),
              ),
              ),

              ///Expandable widget with common textfield
              Obx(()=> PropertyDamageController.to.showStaff==false
                  ?SizedBox()
                  :
              IgnorePointer(
                ignoring: true,
                child: Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:PropertyDamageController.to.staffId,
                    lableText: "Staff ID",
                    hintText: "Enter Staff ID",

                    onChanged: (data){

                    },
                    validator: (data){
                      if(data!.isEmpty){
                        return "Required Staff ID!";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ),


              Obx(()=>PropertyDamageController.to.sghVehicleLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'sgh_vehicle_number',
                  items: PropertyDamageController.to.sghVehicleList,                label: 'SGH Vehicle number'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.sghVehicleNumber,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),
              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.briefDamageDescription,
                  lableText: "Brief Damage Description",
                  hintText: "Enter Brief Damage Description",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              // Ratio Button:
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
                                  20, 20, 20, 10
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, bottom: 10
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1
                                ),
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
                                    title: const Text('Yes'),
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
                                      title: const Text('No'),
                                      value: SingingCharacter.customerComplaints,
                                      groupValue: _character,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ])
                          ),
                          Positioned(
                              left: 50,
                              top: 12,
                              child: Container(
                                width: 275,
                                padding: EdgeInsets.only(
                                    bottom: 10,
                                    left: 10,
                                    right: 10
                                ),
                                color: Colors.white,
                                child: Text(
                                  "Any Injury:".tr,
                                  maxLines: 4,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold
                                  ),
                                ),
                              )
                          ),
                        ],
                      )
                  )
              ),

              // Ratio Button:
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
                                  20, 20, 20, 10
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, bottom: 10
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1
                                ),
                                borderRadius:
                                BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  children: <Widget>[
                                    RadioListTile<SingingCharacter>(
                                      title: const Text('Yes'),
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
                                      title: const Text('No'),
                                      value: SingingCharacter.customerComplaints,
                                      groupValue: _character,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ]
                              )
                          ),
                          Positioned(
                              left: 50,
                              top: 12,
                              child: Container(
                                width: 275,
                                padding: EdgeInsets.only(
                                    bottom: 10,
                                    left: 10,
                                    right: 10
                                ),
                                color: Colors.white,
                                child: Text(
                                  "Any Ambulance:".tr,
                                  maxLines: 4,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold
                                  ),
                                ),
                              )
                          ),
                        ],
                      )
                  )
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.thirdPartyName,
                  lableText: "Third Party Name",
                  hintText: "Enter Third Party Name",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.thirdPartyContactNumber,
                  lableText: "Third Party Contact Number",
                  hintText: "Enter Third Party Contact Number",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.remarks,
                  lableText: "Remarks",
                  hintText: "Remarks",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.descriptionOfAccident,
                  lableText: "Description of Accident",
                  hintText: "Enter Description of Accident  ",
                  onChanged: (data){
                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with dropdown textfield
              Obx(()=>PropertyDamageController.to.correctiveActionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'corrective_action',
                  items: PropertyDamageController.to.correctiveActionList,                label: 'Corrective Action'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.correctiveAction,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),


              ///Expandable widget with common textfield
              Obx(()=>PropertyDamageController.to.preventiveActionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'preventive_action',
                  items: PropertyDamageController.to.preventiveActionList,                label: 'Preventive Action'.tr,

                  isRequired: true,
                  controller: PropertyDamageController.to.preventiveAction,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.insuranceReferenceNumber,
                  lableText: "Insurance Reference Number",
                  hintText: "Enter Insurance Reference Number",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:PropertyDamageController.to.rootCauseAnalysis,
                  lableText: "Root Cause Analysis",
                  hintText: "Root Cause Analysis",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),
              FadeAnimation(1.4,Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: Get.width * 0.9,
                height: null,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,

                ),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "choose to upload".tr, style: TextStyle(fontFamily: "Sakkal Majalla",),
                        ),
                      ),
                    ),

                  ],
                ),
              )),

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
