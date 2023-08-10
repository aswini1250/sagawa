
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofproject/app/controllers/VehicleAccidentController.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

class VehicleAccidentDashboardMyForms extends StatefulWidget {
  VehicleAccidentDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<VehicleAccidentDashboardMyForms> createState() => _VehicleAccidentDashboardMyFormsState();
}

class _VehicleAccidentDashboardMyFormsState extends State<VehicleAccidentDashboardMyForms> {
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
          'Vehicle Accident Form'.tr,
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
                  controller:VehicleAccidentController.to.subject,
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
              Obx(()=>VehicleAccidentController.to.divisionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'division_and_cost_centre',
                  items: VehicleAccidentController.to.division,                label: 'Division and Cost Centre'.tr,

                  isRequired: true,
                  controller:VehicleAccidentController.to.divisionCostCentre,
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
                  controller:VehicleAccidentController.to.customerName,
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
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:VehicleAccidentController.to.placeOfAccurance,
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
                  controller:VehicleAccidentController.to.dateAndTime,
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
                      VehicleAccidentController.to.dateAndTime.text = DateFormat('MM/d/yyyy - hh:mm a').format(datepicked);
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
              Obx(()=>VehicleAccidentController.to.employeeNameLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'employee_name',
                  items:VehicleAccidentController.to.employeeNameList,                label: 'Employee Name'.tr,

                  isRequired: true,
                  controller: VehicleAccidentController.to.employeeName,
                  onChanged: (data) {
                    VehicleAccidentController.to.staffId.text=data['employee_id'];
                    debugPrint("yjbdbfnb fmdsbcjbdsj${data['employee_id']}");
                    VehicleAccidentController.to.showStaff=true;
                  }, cb: (){


                },
                ),
              ),
              ),

              ///Expandable widget with common textfield
              Obx(()=> VehicleAccidentController.to.showStaff==false
                  ?SizedBox()
                  :
              IgnorePointer(
                ignoring: true,
                child: Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:VehicleAccidentController.to.staffId,
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


              ///Expandable widget with common textfield
              Obx(()=>VehicleAccidentController.to.sghVehicleLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'sgh_vehicle_number',
                  items: VehicleAccidentController.to.sghVehicleList,                label: 'SGH Vehicle number'.tr,

                  isRequired: true,
                  controller: VehicleAccidentController.to.sghVehicleNumber,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),


              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:VehicleAccidentController.to.briefDamageDescription,
                  lableText: "Brief Damage Description",
                  hintText: "Enter Brief Damage Description",
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
                  controller:VehicleAccidentController.to.thirdPartyName,
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
                  controller:VehicleAccidentController.to.thirdPartyContactNumber,
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
                  controller:VehicleAccidentController.to.thirdPartyVehicleNumber,
                  lableText: "Third Party Vehicle Number",
                  hintText: "Enter Third Party Vehicle Number",
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

              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:VehicleAccidentController.to.briefDescriptionOfInjury,
                  lableText: "Brief Description of Injury",
                  hintText: "Enter Brief Description of Injury",
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
                                  "Ambulance Involved:".tr,
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
                  controller:VehicleAccidentController.to.remarks,
                  lableText: "Remarks",
                  hintText: "Enter Remarks",
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
                  controller:VehicleAccidentController.to.descriptionOfAccident,
                  lableText: "Description of Accident",
                  hintText: "Enter Description of Accident",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
              ),

              ///Expandable widget with dropdown textfield
              Obx(()=>VehicleAccidentController.to.correctiveActionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'corrective_action',
                  items: VehicleAccidentController.to.correctiveActionList,                label: 'Corrective Action'.tr,

                  isRequired: true,
                  controller: VehicleAccidentController.to.correctiveAction,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),


              ///Expandable widget with common textfield
              Obx(()=>VehicleAccidentController.to.preventiveActionLoading == true
                  ? Container(
                  height: 60, width: 60, child: ProgressLoading())
                  :
              Container(
                width:   Get.width*.9,

                child: MainSearchableDropDown(
                  title: 'preventive_action',
                  items: VehicleAccidentController.to.preventiveActionList,                label: 'Preventive Action'.tr,

                  isRequired: true,
                  controller: VehicleAccidentController.to.preventiveAction,
                  onChanged: (data) {
                  }, cb: (){},
                ),
              ),
              ),


              ///Expandable widget with common textfield
              Container(
                width:   Get.width*.9,
                child: CommonTextFormManPowerField(
                  controller:VehicleAccidentController.to.rootCauseAnalysis,
                  lableText: "Root Cause Analysis",
                  hintText: "Enter Root Cause Analysis",
                  onChanged: (data){

                  },
                  validator: (data){
                    return null;
                  },
                ),
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
