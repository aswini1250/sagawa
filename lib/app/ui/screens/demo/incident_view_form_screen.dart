

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/config/app_config.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/commonToast.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../../../controllers/incident_controller.dart';

import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class IncidentViewFormScreen extends StatefulWidget {
  IncidentViewFormScreen({Key? key,required this.ignoring,required this.incident_user_id,
  required this.canShowSection2ForApprovals}) : super(key: key);

  final String incident_user_id;
  final bool ignoring;
  final bool canShowSection2ForApprovals;
  @override
  State<IncidentViewFormScreen> createState() => _IncidentViewFormScreenState();
}

class _IncidentViewFormScreenState extends State<IncidentViewFormScreen> {
  TextEditingController jobDescriptionController=TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKeyApp = GlobalKey<FormState>();



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

  initiallySetImagesFromBackend(){

  }

  @override
  void initState(){
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
      body:
      Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: section1(),
        ),
      ),
    );
  }

  Widget section1() {
    return Column(
      children: [
        IgnorePointer(
          ignoring: widget.ignoring,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Section-01",style: TextStyle(color: AppColors.primaryColor,fontSize: 20)),
                ),
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
                    items: IncidentController.to.preventiveActionList,
                    label: 'Preventive Action'.tr,
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
                // Row(
                //   children: [
                //     Text("Incident Uploads:"),
                //     SizedBox(),
                //     Text("Document(${IncidentController.to.incidentUploads.text})")
                //   ],
                // ),



              ],
            ),
          ),
        ),

        Obx(()=>IncidentController.to.showButton==false?
         CommonButton(text: "Choose files", width: Get.width*.7,
              onPressed: (){

                _pickFiles();
              }):SizedBox(),
        ),
        SizedBox(height: 16),
        Obx(()=>IncidentController.to.showImage==false?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: IncidentController.to.selectedFiles.length,
          itemBuilder: (BuildContext context, index) {

            final file = IncidentController.to.selectedFiles[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: InkWell(
                      onTap:(){
                        OpenFilex.open("${file.path}");
                      },
                      child: Text("${file.path}".split("/")[7])),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeFile(file);
                      Fluttertoast.showToast(msg: 'File removed');
                    },
                  ),
                ),
                InkWell(
                  onTap:() async{
                    OpenFilex.open(file.path);
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
        ):
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: IncidentController.to.incidentUploads.length,
          itemBuilder: (BuildContext context, index) {

            final file = IncidentController.to.incidentUploads[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: InkWell(
                      onTap:(){
                        //OpenFilex.open("${file.path}");
                      },
                      child:

                      Text("${file['uploadfile_path']}".split("/")[5])),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeFile(file);
                      Fluttertoast.showToast(msg: 'File removed');
                    },
                  ),
                ),
                InkWell(
                  onTap:() async{
                    // if(file['uploadfile_path'].toString().contains(".jpg")||file['uploadfile_path'].toString().contains(".jpeg")||file['uploadfile_path'].toString().contains(".png")||file['uploadfile_path'].toString().contains(".gif"))
                    // {
                    //   showMyDialog("test",AppConfig.imgUrl+file['uploadfile_path']);
                    // }

                    final extension = p.extension(IncidentController.to.incidentUploads[index]['uploadfile_path']); // '.dart'
                    debugPrint("extension of file name ${extension}");
                    final http.Response responseData = await http.get(Uri.parse("${AppConfig.imgUrl}${ IncidentController.to.incidentUploads[index]['uploadfile_path']}"));
                    Uint8List uint8list = responseData.bodyBytes;
                    var buffer = uint8list.buffer;
                    ByteData byteData = ByteData.view(buffer);
                    var tempDir = await getTemporaryDirectory();
                    File file = await File('${tempDir.path}/incident_document$extension').writeAsBytes(
                        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                    OpenFilex.open(file.path);
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
        SizedBox(height: 16),

        Obx(()=>IncidentController.to.showButton==false?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonButton(title: "Cancel", onTap: (){

                IncidentController.to.clearFormField();
              }),
              commonButton(title: "Submit", onTap: () async{
                if(_formKey.currentState!.validate()) {
                  await   IncidentController.to.updateIncidents(user_id: '${widget.incident_user_id}');

                }else{
                  CommonToast.show(msg: "Please fill all fields");
                }
              })

            ],
          ),
        ):SizedBox(),
        ),


        SizedBox(height: 10,),
        Obx(()=>IncidentController.to.viewButton==true &&IncidentController.to.showsectionSection=="1"?
        SizedBox():
    widget.canShowSection2ForApprovals==true?
        section2():SizedBox()
        )
      ],
    );
  }
  Widget section2() {
    return Form(
      key: _formKeyApp,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Section-02",style: TextStyle(color: AppColors.primaryColor,fontSize: 20)),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              width:   Get.width*.9,
              child: CommonTextFormManPowerField(
                controller:IncidentController.to.subjectApp,
                lableText: "User Name",
                hintText: "Enter User Name",
                onChanged: (data)async{

                },
                validator: (data){

                  return null;
                },
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,

            child: Container(
              width:   Get.width*.9,
              child: CommonTextFormManPowerField(
                controller:IncidentController.to.designationApp,
                lableText: "Designation",
                hintText: "Enter Designation",

                onChanged: (data)async{
                },
                validator: (data){

                  return null;
                },
              ),
            ),
          ),

          ///Expandable widget with common textfield
          IgnorePointer(
            ignoring: true,
            child: Container(
              width:   Get.width*.9,
              child: CommonTextFormManPowerField(
                controller:IncidentController.to.dateAndTimeApp,
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
                    IncidentController.to.dateAndTimeApp.text = DateFormat('yyyy-MM-dd  hh:mm:ss').format(DateTime.now());
                  }
                },
                hintText: "Enter Date and Time",
                onChanged: (data){
                 // =IncidentController.to.dateAndTimeApp.text;
                },
                validator: (data){

                  return null;
                },
              ),
            ),
          ),
          Container(
            width:   Get.width*.9,
            child: CommonTextFormManPowerField(
              controller:IncidentController.to.descrioptionApp,
              lableText: "Description *",
              hintText: "Enter Description",
              onChanged: (data){

              },
              validator: (data){
                if(data!.isEmpty){
                  return "Required Description!";
                }
                return null;
              },
            ),
          ),



          Obx(()=>IncidentController.to.viewButton==false?
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonButton(title: "Approve", onTap: ()async{
                  if(_formKeyApp.currentState!.validate()) {
                    await   IncidentController.to.updateIncidentApprovals(incident_user_id: '${widget.incident_user_id}', approveId: '1');

                  }else{
                    CommonToast.show(msg: "Please fill all fields");
                  }
                }),
                commonButton(title: "Reject", onTap: () async{
                  if(_formKeyApp.currentState!.validate()) {
                    await   IncidentController.to.updateIncidentApprovals(incident_user_id: '${widget.incident_user_id}', approveId: '0');

                  }else{
                    CommonToast.show(msg: "Please fill all fields");
                  }
                })

              ],
            ),
          ):SizedBox(),
          ),

        ],
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


final extension = p.extension('file.dart.js', 2); // '.dart.js'
