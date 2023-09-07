

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/commonToast.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../../controllers/incident_controller.dart';
import '../../widgets/commonExpandableRadioButton.dart';

import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:get/get_core/src/get_main.dart';

class IncidentDashboardMyForms extends StatefulWidget {
  IncidentDashboardMyForms({Key? key}) : super(key: key);

  @override
  State<IncidentDashboardMyForms> createState() => _IncidentDashboardMyFormsState();
}

class _IncidentDashboardMyFormsState extends State<IncidentDashboardMyForms> {
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
        IncidentController.to.selectedFiles.addAll(files);
        debugPrint("iiiimages${  IncidentController.to.selectedFiles.length}");
      });
    }
  }

  void _removeFile(File file) {
    setState(() {
      IncidentController.to.selectedFiles.remove(file);
    });
  }

  @override
  void initState() {
    super.initState();

    IncidentController.to.getDivisionList();
    IncidentController.to.getEmployeeList();
    IncidentController.to.getSGHVehicle();
    IncidentController.to.getCorrectiveAction();

    IncidentController.to.getPreventiveAction();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        backgroundColor: AppColors.primaryColor,
        title: new Text(
          'Incident Form'.tr,
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
                                    children: <Widget>[   RadioListTile<String>(
                                      title: const Text('Near Miss'),
                                      activeColor: AppColors.primaryColor,
                                      value: "Near Miss",
                                      groupValue: IncidentController.to.character,
                                      onChanged: (String? value) {
                                        setState(() {
                                          IncidentController.to.character= value;
                                        });
                                      },
                                    ),
                                      RadioListTile<String>(
                                        title: const Text('Customer Complaints'),
                                        value: "Customer Complaints",
                                        groupValue: IncidentController.to.character,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            IncidentController.to.character = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        title: const Text('General Incidents'),
                                        value: "General Incidents",
                                        groupValue: IncidentController.to.character,
                                        activeColor: AppColors.primaryColor,
                                        onChanged: (String? value) {
                                          setState(() {
                                            IncidentController.to.character = value;
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
                                        color: AppColors.primaryColor,
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
                    controller:IncidentController.to.subject,
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
                Obx(()=>IncidentController.to.divisionLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'division_and_cost_centre',
                    items: IncidentController.to.division,                label: 'Division and Cost Centre'.tr,

                    isRequired: false,
                    controller:IncidentController.to.divisorCostCentre,
                    onChanged: (data) {
                      IncidentController.to.senddivisorCostCentreId=data["id"];
                      debugPrint("dhgsfghafhdhfvhgdv${data}");

                    }, cb: (){

                  },
                  ),
                ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.customerName,
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
                    controller:IncidentController.to.placeOfAccurance,
                    lableText: "Place of Occurrence",
                    hintText: "Enter Place of Occurrence",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Place of Occurrence!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.dateAndTime,
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
                        IncidentController.to.dateAndTime.text = DateFormat('yyyy-MM-dd  hh:mm:ss').format(datepicked);
                      }
                    },
                    hintText: "Enter Date and Time",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Date and Time!";
                      // }
                      return null;
                    },
                  ),
                ),

                /// common dropdown
                Obx(()=>IncidentController.to.employeeNameLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'employee_name',
                    items:IncidentController.to.employeeNameList,                label: 'Employee Name'.tr,

                    isRequired: true,
                    controller: IncidentController.to.employeeName,
                    onChanged: (data) {
                      IncidentController.to.sendEmployeeNameId=data["id"];
                      debugPrint("dhgsfghafhdhfvhgdv${data}");
                      IncidentController.to.staffId.text=data['employee_id'];
                      debugPrint("yjbdbfnb fmdsbcjbdsj${data['employee_id']}");
                      IncidentController.to.showStaff=true;
                    }, cb: (){


                  },
                  ),
                ),
                ),

                ///Expandable widget with common textfield
                Obx(()=> IncidentController.to.showStaff==false
                    ?SizedBox()
                    :
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width:   Get.width*.9,
                    child: CommonTextFormManPowerField(
                      controller:IncidentController.to.staffId,
                      lableText: "Staff ID",
                      hintText: "Enter Staff ID",

                      onChanged: (data){

                      },
                      validator: (data){
                        // if(data!.isEmpty){
                        //   return "Required Staff ID!";
                        // }
                        return null;
                      },
                    ),
                  ),
                ),
                ),

                ///Expandable widget with common textfield
                Obx(()=>IncidentController.to.sghVehicleLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'sgh_vehicle_number',
                    items: IncidentController.to.sghVehicleList,                label: 'SGH Vehicle number'.tr,

                    isRequired: false,
                    controller: IncidentController.to.sghVehicleNumber,
                    onChanged: (data) {
                    }, cb: (){},
                  ),
                ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.consigneeShipper,
                    lableText: "Consignee / shipper",
                    hintText: "Consignee / shipper",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Consignee / shipper!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.mawb,
                    lableText: "MAWB",
                    hintText: "Enter MAWB",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required MAWB!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.hawb,
                    lableText: "HAWB",
                    hintText: "Enter HAWB",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required HAWB!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.totalQuantityOfItem,
                    lableText: "Total Quantity of Item",
                    hintText: "Enter Total Quantity of Item",
                    keyboardType: TextInputType.number,
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Total Quantity of Item!";
                      // }

                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.weight,
                    lableText: "Weight",
                    hintText: "Enter Weight",
                    keyboardType: TextInputType.number,
                    onChanged: (data){
                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Weight!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.quantityOfDamaged,
                    lableText: "Quantity of Damaged",
                    hintText: "Enter Quantity of Damaged",
                    keyboardType: TextInputType.number,
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Quantity of Damaged!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.remarks,
                    lableText: "Remarks",
                    hintText: "Enter Remarks",
                    maxlines: 3,
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Remarks!";
                      // }
                      return null;
                    },
                  ),
                ),

                ///Expandable widget with dropdown textfield
                Obx(()=>IncidentController.to.correctiveActionLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'corrective_action',
                    items: IncidentController.to.correctiveActionList,                label: 'Corrective Action'.tr,

                    isRequired: false,
                    controller: IncidentController.to.correctionAction,
                    onChanged: (data) {
                    }, cb: (){},
                  ),
                ),
                ),


                ///Expandable widget with common textfield
                Obx(()=>IncidentController.to.preventiveActionLoading == true
                    ? Container(
                    height: 60, width: 60, child: ProgressLoading())
                    :
                Container(
                  width:   Get.width*.9,

                  child: MainSearchableDropDown(
                    title: 'preventive_action',
                    items: IncidentController.to.preventiveActionList,                label: 'Preventive Action'.tr,

                    isRequired: false,
                    controller: IncidentController.to.preventiveAction,
                    onChanged: (data) {
                    }, cb: (){},
                  ),
                ),
                ),

                ///Expandable widget with common textfield
                Container(
                  width:   Get.width*.9,
                  child: CommonTextFormManPowerField(
                    controller:IncidentController.to.rootCauseAnalysis,
                    lableText: "Root Cause Analysis",
                    hintText: "Enter Root Cause Analysis",
                    onChanged: (data){

                    },
                    validator: (data){
                      // if(data!.isEmpty){
                      //   return "Required Root Cause Analysis!";
                      // }
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
                      itemCount: IncidentController.to.selectedFiles.length,
                      itemBuilder: (BuildContext context, index) {

                        final file = IncidentController.to.selectedFiles[index];
                        return  Column(
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

                        IncidentController.to.clearFormField();
                      }),
                      commonButton(title: "Submit", onTap: (){
                        if(_formKey.currentState!.validate()) {
                          IncidentController.to.saveIncidents();
                        }else{
                          CommonToast.show(msg: "Please fill all fields");
                        }
                      })

                    ],
                  ),
                ),

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


