

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sofproject/app/controllers/VehicleAccidentController.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/commonToast.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

class VehicleAccidentDashboardMyForms extends StatefulWidget {
  VehicleAccidentDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<VehicleAccidentDashboardMyForms> createState() => _VehicleAccidentDashboardMyFormsState();
}

class _VehicleAccidentDashboardMyFormsState extends State<VehicleAccidentDashboardMyForms> {
  TextEditingController jobDescriptionController=TextEditingController();
  final _formKey = GlobalKey<FormState>();


  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        VehicleAccidentController.to.selectedFiles.addAll(files);
        debugPrint("iiiimages${  VehicleAccidentController.to.selectedFiles.length}");
      });
    }
  }

  void _removeFile(File file) {
    setState(() {
      VehicleAccidentController.to.selectedFiles.remove(file);
    });
  }


  @override
  void initState() {
    super.initState();
    VehicleAccidentController.to.showBodyParts=true;

    VehicleAccidentController.to.getDivisionList();
    VehicleAccidentController.to.getEmployeeList();
    VehicleAccidentController.to.getSGHVehicle();
    VehicleAccidentController.to.getCorrectiveAction();

    VehicleAccidentController.to.getPreventiveAction();

  }
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
      body: Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

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

                    isRequired: false,
                    controller:VehicleAccidentController.to.divisionCostCentre,
                    onChanged: (data) {
                      VehicleAccidentController.to.senddivisorCostCentreId=data["id"];

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
                        VehicleAccidentController.to.dateAndTime.text = DateFormat('yyyy-MM-dd  hh:mm:ss').format(datepicked);
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
                      VehicleAccidentController.to.sendEmployeeNameId=data["id"];

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

                    isRequired: false,
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
                                    children: <Widget>[   RadioListTile<String>(
                                      title: const Text('Yes'),
                                      activeColor: AppColors.primaryColor,
                                      value: "Yes",
                                      groupValue: VehicleAccidentController.to.anyInjury,
                                      onChanged: (String? value) {
                                        setState(() {
                                          VehicleAccidentController.to.anyInjury= value;
                                          VehicleAccidentController.to.showBodyParts=true;

                                        });
                                      },
                                    ),
                                      RadioListTile<String>(
                                        title: const Text('No'),
                                        value: "No",
                                        groupValue: VehicleAccidentController.to.anyInjury,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            VehicleAccidentController.to.anyInjury = value;
                                            VehicleAccidentController.to.showBodyParts=false;
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
                Obx(()=>VehicleAccidentController.to.showBodyParts==true?
                  Container(
                    width:   Get.width*.9,
                    child: CommonTextFormManPowerField(
                      controller:VehicleAccidentController.to.bodyParts,
                      lableText: "Body Parts",
                      hintText: "Enter Body Parts",
                      onChanged: (data){

                      },
                      validator: (data){
                        return null;
                      },
                    ),
                  ):SizedBox(),
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
                                    children: <Widget>[   RadioListTile<String>(
                                      title: const Text('Yes'),
                                      activeColor: AppColors.primaryColor,
                                      value: "Yes",
                                      groupValue: VehicleAccidentController.to.ambulaneInoled,
                                      onChanged: (String? value) {
                                        setState(() {
                                          VehicleAccidentController.to.ambulaneInoled= value;
                                        });
                                      },
                                    ),
                                      RadioListTile<String>(
                                        title: const Text('No'),
                                        value: "No",
                                        groupValue: VehicleAccidentController.to.ambulaneInoled,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            VehicleAccidentController.to.ambulaneInoled = value;
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

                    isRequired: false,
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

                    isRequired: false,
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



                CommonButton(text: "Choose files", width: Get.width*.7,
                    onPressed: (){

                      _pickFiles();
                    }),
                SizedBox(height: 16),
                Obx(()=>
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: VehicleAccidentController.to.selectedFiles.length,
                  itemBuilder: (BuildContext context, index) {

                    final file = VehicleAccidentController.to.selectedFiles[index];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text("${file.path}".split("/")[7]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDeleteAlertDialog(
                                  Get.context!,
                                  file:file);
                            },
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            OpenFilex.open("${file.path}");


                          },

                          child: Center(
                            child: Container(
                              width: Get.width*.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.purple
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text("Click to view",style: TextStyle(fontSize: 12,color: AppColors.white),),
                                    Icon(Icons.preview_rounded,color: AppColors.white,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
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

                        VehicleAccidentController.to.clearFormField();
                      }),
                      commonButton(title: "Submit", onTap: (){
                        if(_formKey.currentState!.validate()) {
                         VehicleAccidentController.to.saveAccidents();
                        }else{
                          CommonToast.show(msg: "Please fill all fields");
                        }
                      })

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  showDeleteAlertDialog(BuildContext context, {required File file}) {
    // set up the buttons
    Widget cancelButton = commonButton(

      title: "Cancel",onTap: (){
      Get.back();
    },
    );
    Widget continueButton =   commonButton(
      title: "Confirm",onTap: (){

      _removeFile(file);
      Fluttertoast.showToast(msg: 'File removed');
      Get.back();


    },
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
        "Are you sure you want to delete?".tr,
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

}
