import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sofproject/app/controllers/controller.dart';
import 'package:sofproject/app/controllers/gtwController.dart';
import 'package:sofproject/app/ui/widgets/Animation/FadeAnimation.dart';
import 'package:sofproject/app/ui/widgets/color.dart';
import 'package:sofproject/app/ui/widgets/commonTextManpowerField.dart';
import 'package:sofproject/app/ui/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import 'package:intl/intl.dart';

class GeneralPermitForm extends StatelessWidget {
  const GeneralPermitForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          backgroundColor: primary_light,
          title: new Text(
            'General Permit Request Form'.tr,
            style: TextStyle(),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                  child: Form(
                  //  key: _key,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                      width: Get.width*0.8,
                            child: MainSearchableDropDown(

                              items: [{
                                "department":"IT",
                              },{
                                "department":"Non-It"
                              }],
                              //initialValue: "Male",
                              title: "department",
                              isRequired: true,
                              label: "department".tr,
                              controller: GtwController.to.department,
                              onChanged: (data ) {
                                //ManpowerController.to.selected=data;
                              }, cb: (){},
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: Get.width*0.8,
                            child: MainSearchableDropDown(

                              items: [{
                                "Section/Area":"IT",
                              },{
                                "Section/Area":"Non-It"
                              }],
                              //initialValue: "Male",
                              title: "Section/Area",
                              isRequired: true,
                              label: "Section/Area".tr,
                              controller: GtwController.to.department,
                              onChanged: (data ) {
                                //ManpowerController.to.selected=data;
                              }, cb: (){},
                            ),
                          ),
                          Container(
                            width: Get.width*.8,
                            child: CommonTextFormManPowerField(
                              controller: GtwController.to.permitValidTo,
                              isDatePicker:true,
                              //////////////////////////////////////
                              lableText: "permitValid To".tr,
                              hintText: "permitValidTo".tr,

                              order: 6,
                              validator: (String? data) {
                                if (data == "" || data == null) {
                                  return "permitValidTo".tr;
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
                                  GtwController.to.permitValidTo.text = DateFormat('dd-MM-yyyy').format(datepicked);
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: Get.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: grocery_ShadowColor,

                            ),
                            child:DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'MM/d/yyyy - hh:mm a',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: "Hour",
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) => print(val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            )

                          ),











                        ],
                      ),
                    ),
                  ))),
        ));  }
}
