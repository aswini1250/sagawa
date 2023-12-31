

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../../controllers/property_damage_controller.dart';
import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/commonToast.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

class PropertyDamageDashboardMyForms extends StatefulWidget {
  PropertyDamageDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<PropertyDamageDashboardMyForms> createState() => _PropertyDamageDashboardMyFormsState();
}

class _PropertyDamageDashboardMyFormsState extends State<PropertyDamageDashboardMyForms> {
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
        PropertyDamageController.to.selectedFiles.addAll(files);
        debugPrint("iiiimages${  PropertyDamageController.to.selectedFiles.length}");
      });
    }
  }

  void _removeFile(File file) {
    setState(() {
      PropertyDamageController.to.selectedFiles.remove(file);
    });
  }

init()async{
  PropertyDamageController.to.showBodyParts=true;

  SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
  PropertyDamageController.to.editorName.text=aswiniPrefs.getString("editor_name")??"";
  PropertyDamageController.to.creatorNameController.text=aswiniPrefs.getString("creator_name")??"";

}
  @override
  void initState() {
    super.initState();
    init();
    PropertyDamageController.to.getDivisionList();
    PropertyDamageController.to.getEmployeeList();
    PropertyDamageController.to.getSGHVehicle();
    PropertyDamageController.to.getCorrectiveAction();

    PropertyDamageController.to.getPreventiveAction();

  }
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
                Obx(()=>PropertyDamageController.to.divisionLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'division_and_cost_centre',
                    items: PropertyDamageController.to.division,                label: 'Division and Cost Centre'.tr,

                    isRequired: false,
                    controller:PropertyDamageController.to.divisionCostCentre,
                    onChanged: (data) {
                      PropertyDamageController.to.senddivisorCostCentreId=data["id"];

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



                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width:   Get.width*.9,

                    child: MainSearchableDropDown(
                      title: 'Creator Name',
                      items:PropertyDamageController.to.creatorName,                label: 'Creator Name'.tr,
                      isRequired: false,
                      controller: PropertyDamageController.to.creatorNameController,
                      onChanged: (data) {

                      }, cb: (){


                    },
                    ),
                  ),
                ),

                /// common dropdown

                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width:   Get.width*.9,

                    child: MainSearchableDropDown(
                      title: 'Editor Name',
                      items:PropertyDamageController.to.editorNewName,                label: 'Editor Name'.tr,

                      isRequired: false,
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
                        PropertyDamageController.to.dateAndTime.text = DateFormat('yyyy-MM-dd  hh:mm:ss').format(datepicked);
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
                      PropertyDamageController.to.sendEmployeeNameId=data["id"];

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


                ///Expandable widget with common textfield
                Obx(()=>PropertyDamageController.to.sghVehicleLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'sgh_vehicle_number',
                    items: PropertyDamageController.to.sghVehicleList,                label: 'SGH Vehicle number'.tr,

                    isRequired: false,
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



                ///Expandable widget with common textfield

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
                                      groupValue: PropertyDamageController.to.anyInjury,
                                      onChanged: (String? value) {
                                        setState(() {
                                          PropertyDamageController.to.anyInjury= value;
                                          PropertyDamageController.to.showBodyParts=true;

                                        });
                                      },
                                    ),
                                      RadioListTile<String>(
                                        title: const Text('No'),
                                        value: "No",
                                        groupValue: PropertyDamageController.to.anyInjury,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            PropertyDamageController.to.anyInjury = value;
                                            PropertyDamageController.to.showBodyParts=false;
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
                Obx(()=>PropertyDamageController.to.showBodyParts==true?
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:PropertyDamageController.to.bodyParts,
                    lableText: "Injured Body Parts",
                    hintText: " Body Parts",
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
                    controller:PropertyDamageController.to.briefDescriptionOfInjury,
                    lableText: "Brief Description",
                    hintText: "Enter Brief Description ",
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
                                      groupValue: PropertyDamageController.to.ambulaneInoled,
                                      onChanged: (String? value) {
                                        setState(() {
                                          PropertyDamageController.to.ambulaneInoled= value;
                                        });
                                      },
                                    ),
                                      RadioListTile<String>(
                                        title: const Text('No'),
                                        value: "No",
                                        groupValue: PropertyDamageController.to.ambulaneInoled,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            PropertyDamageController.to.ambulaneInoled = value;
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
                    controller:PropertyDamageController.to.descriptionOfAccident,
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
                Obx(()=>PropertyDamageController.to.correctiveActionLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'corrective_action',
                    items: PropertyDamageController.to.correctiveActionList,                label: 'Corrective Action'.tr,

                    isRequired: false,
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

                    isRequired: false,
                    controller: PropertyDamageController.to.preventiveAction,
                    onChanged: (data) {
                    }, cb: (){},
                  ),
                ),
                ),

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
                  itemCount: PropertyDamageController.to.selectedFiles.length,
                  itemBuilder: (BuildContext context, index) {

                    final file = PropertyDamageController.to.selectedFiles[index];
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

                              // _removeFile(file);

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
                )
                ),



                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonButton(title: "Cancel", onTap: (){

                        PropertyDamageController.to.clearFormField();
                      }),
                      commonButton(title: "Submit", onTap: (){
                        if(_formKey.currentState!.validate()) {
                          PropertyDamageController.to.saveAccidents();
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
