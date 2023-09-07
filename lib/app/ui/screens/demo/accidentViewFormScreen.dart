import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/config/app_config.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

import '../../../controllers/VehicleAccidentController.dart';
import '../../widgets/commonExpandableRadioButton.dart';
import '../../widgets/commonToast.dart';
import '../../widgets/progress_loading.dart';
import '../../widgets/utils/fade_animation_TRL.dart';
import 'dart:io';
class VehicleAccidentViewForms extends StatefulWidget {
  VehicleAccidentViewForms({Key? key,required this.ignoring,required this.canShowSection2ForApprovals, required this.accident_user_id}) : super(key: key);
  final bool ignoring;
  final String accident_user_id;
  final bool canShowSection2ForApprovals;

  @override
  State<VehicleAccidentViewForms> createState() => _VehicleAccidentViewFormsState();
}

class _VehicleAccidentViewFormsState extends State<VehicleAccidentViewForms> {
  TextEditingController jobDescriptionController=TextEditingController();

  SingingCharacter? _character = SingingCharacter.nearMiss;
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
  init()async{
    VehicleAccidentController.to.showBodyParts=true;

    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
    VehicleAccidentController.to.designationApp.text=aswiniPrefs.getString("designation_name")??"";
    VehicleAccidentController.to.subjectApp.text=aswiniPrefs.getString("user_name")??"";
    VehicleAccidentController.to.dateAndTimeApp.text="${DateFormat("yyyy-MM-dd  hh:mm:ss").format(DateTime.now())}"??"";
  }


  @override
  void initState() {
    super.initState();
    init();
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
      body:   Container(
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
                        items: VehicleAccidentController.to.sghVehicleList,                label: 'SGH VehicleAccidentController number'.tr,

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
                        lableText: "Third Party VehicleAccidentController Number",
                        hintText: "Enter Third Party VehicleAccidentController Number",
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


                  ],
                ),
          ),
        ),
        Obx(()=>VehicleAccidentController.to.showButton==false?
        CommonButton(text: "Choose files", width: Get.width*.7,
            onPressed: (){

              _pickFiles();
            }):SizedBox(),
        ),
        SizedBox(height: 16),
        Obx(()=>VehicleAccidentController.to.showImage==false?
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
          itemCount: VehicleAccidentController.to.incidentUploads.length,
          itemBuilder: (BuildContext context, index) {

            final file = VehicleAccidentController.to.incidentUploads[index];
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

                    final extension = p.extension(VehicleAccidentController.to.incidentUploads[index]['uploadfile_path']); // '.dart'
                    debugPrint("extension of file name ${extension}");
                    final http.Response responseData = await http.get(Uri.parse("${AppConfig.imgUrl}${ VehicleAccidentController.to.incidentUploads[index]['uploadfile_path']}"));
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

        Obx(()=>VehicleAccidentController.to.showButton==false?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonButton(title: "Cancel", onTap: (){

                VehicleAccidentController.to.clearFormField();
              }),
              commonButton(title: "Submit", onTap: () async{

                debugPrint("ghghavdhgva");

                if(_formKey.currentState!.validate()) {

                  debugPrint("ghghavdhgva");
                  await   VehicleAccidentController.to.updateAccidents(user_id: '${widget.accident_user_id}');

                }else{
                  CommonToast.show(msg: "Please fill all fields");
                }
              })

            ],
          ),
        ):SizedBox(),
        ),



        Obx(()=>VehicleAccidentController.to.viewButton==true &&
            VehicleAccidentController.to.showsectionSection=="1"?
        SizedBox():
        widget.canShowSection2ForApprovals==true?

        section2():SizedBox())


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
                controller:VehicleAccidentController.to.subjectApp,
                lableText: "User Name",
                hintText: "Enter User Name",
                onChanged: (data){

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
                controller:VehicleAccidentController.to.designationApp,
                lableText: "Designation",
                hintText: "Enter Designation",
                onChanged: (data){

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
                controller:VehicleAccidentController.to.dateAndTimeApp,
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
                    VehicleAccidentController.to.dateAndTimeApp.text = DateFormat('yyyy-MM-dd  hh:mm:ss').format(datepicked);
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
          ),
          Container(
            width:   Get.width*.9,
            child: CommonTextFormManPowerField(
              controller:VehicleAccidentController.to.descrioptionApp,
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



          Obx(()=>VehicleAccidentController.to.viewButton==false?
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonButton(title: "Approve", onTap: ()async{
                    if(_formKeyApp.currentState!.validate()) {
                      await   VehicleAccidentController.to.updateIncidentApprovals(accident_user_id: '${widget.accident_user_id}', approveId: '1');

                    }else{
                      CommonToast.show(msg: "Please fill all fields");
                    }
                  }),
                  commonButton(title: "Reject", onTap: () async{
                    if(_formKeyApp.currentState!.validate()) {
                      await   VehicleAccidentController.to.updateIncidentApprovals(accident_user_id: '${widget.accident_user_id}', approveId: '0');

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

}
