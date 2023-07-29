import 'package:sofproject/app/controllers/controller.dart';
import 'package:sofproject/app/ui/screens/demo/login_page.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/progress_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../widgets/commonTextManpowerField.dart';
import '../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../widgets/common_textform_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final loginFormKey=GlobalKey<FormState>();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthController.to.getList();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer Details",style: TextStyle(fontSize: 20,color: AppColors.primaryColor)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Get.width*0.7,
                child: CommonTextFormField(
                  controller: AuthController.to.personalDetails,
                  hintText: "User name",
                  lableText: "User name",
                  validator: (String? data){
                  },
                ),
              ),



            ],
          ),

          CommonTextFormManPowerField(
            hintText: "Phone number".tr,
            lableText: "Phone number".tr,
            order: 5,
            controller: AuthController.to.phonenumber,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],
            validator: (String? data) {
              if (data == "" || data == null) {
                return "Enter the phone number".tr;
              } else {
                return null;
              }
            },
            onTap: () async {},
          ),
          CommonTextFormManPowerField(
            controller: AuthController.to.dateOfBirth,
            isDatePicker:true,
            //////////////////////////////////////
            lableText: "Date of birth".tr,
            hintText: "Date of birth".tr,

            order: 6,
            validator: (String? data) {
              if (data == "" || data == null) {
                return "date_of_birth_error".tr;
              } else {
                return null;
              }
            },
            onTap: () async {
              print("test tap");
              DateTime? datepicked = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2025));
              if (datepicked != null) {
                AuthController.to.dateOfBirth.text = DateFormat('dd-MM-yyyy').format(datepicked);
              }
            },
          ),
          MainSearchableDropDown(

            items: [{
              "gender":"Male",
            },{
              "gender":"Female"
            }],
            //initialValue: "Male",
            title: "gender",
            isRequired: true,
            label: "gender".tr,
            controller: AuthController.to.gender,
            onChanged: (data ) {
              //ManpowerController.to.selected=data;
            }, cb: (){},
          ),

              MainSearchableDropDown(
                title: 'location',
                isRequired: true,
                items: [{
                  "location":"Coimbatore",
                },{
                  "location":"Bangalore"
                }],
                label: 'Location'.tr,

                controller: AuthController.to.location,
                onChanged: (data ) {
                }, cb: (){},),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             children: [
               commonButton(title: "Cancel".tr,
                 onTap: (){


                   }
                 ,),    SizedBox(height: 50,width: 40,),
               commonButton(title: "Submit".tr,
                 onTap: (){
                   AuthController.to.addNamesToList();

                 }

                 ,),

             ],
           ),
         ),
          Obx(
                () => AuthController.to.loading == true
                ? loadingPart()
                : AuthController.to.nameList.isEmpty
                ? emptyPart()
                : listPart(),
          ),
         // checkboxPart(),
     // gridviewPart()
        ])

    );
  }

  GridView gridviewPart() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10),
     
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: .5/ 0.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 4),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
      decoration: BoxDecoration(color: AppColors.red,borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
Image.asset('assets/images/boreweller_logo.png',height: 50,color: AppColors.primaryColor,fit: BoxFit.fill,),
        Text("aswini"),
            Text("aravind"),
              checkboxPart()
            ],
          ),

);
});
  }

  Obx checkboxPart() {
    return Obx(()=>
        AuthController.to.getRefreshData==true || AuthController.to.getRefreshData==false?AuthController.to.getListLoading==true?ProgressLoading():AuthController.to.getListList.isEmpty?Container(height: 10,width: 10,child: Text("nodata"),):
          ListView.builder(
            shrinkWrap: true,
            itemCount: AuthController.to.getListList.length,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                height: 100,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),

                  color: AppColors.red
                ),
                child: Column(
                  children:<Widget>[


                     Text("${AuthController.to.getListList[index]['name']}",style: TextStyle(fontSize: 20,color: AppColors.white),),

                  //  Text("${AuthController.to.choosenAllData[index]['name']}",style: TextStyle(fontSize: 20,color: AppColors.white),),
                Checkbox(
                    value: AuthController.to.getListList[index]['chosen'],

                    onChanged: (bool? value) {
                      AuthController.to.getRefreshData=true;
                      AuthController.to.getListList[index]['chosen']=value;
                      AuthController.to.getRefreshData=false;

                    })],
                ),
              );
            }

          ):SizedBox(),
        );
  }

  CommonButton buttonPart() {
    return CommonButton(text: "submit",color: AppColors.blue,onPressed: (){
          AuthController.to.updateOnlychoosenData();
        },);
  }
}
