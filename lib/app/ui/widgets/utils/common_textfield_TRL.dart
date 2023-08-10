import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';

class CommonTextField extends StatelessWidget {
   const CommonTextField({Key? key,
     this.onChange,
     required this.validator,
     this.iconColor=Colors.black,
     required this.hintText,
     required this.labelText,
     required this.controller,
     this.icon=Icons.speaker_notes_rounded

  }) : super(key: key,
);
  final Function(String?)? onChange;
  final String hintText;
  final String labelText;
  final Color iconColor;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
       controller: controller,
        style: TextStyle(),
        //initialValue: reported_by,
        keyboardType: TextInputType.multiline,
        textInputAction:
        TextInputAction.newline,

        minLines: 1,
        maxLines: null,
        obscureText: false,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: iconColor,
          ),
         // fillColor: AppColors.dropdownColor,
          labelText: hintText,
          hintText: labelText,
          border: InputBorder.none,
        ),
        // keyboardType: TextInputType.number,
        onChanged: (value) {
          onChange!(value);

          // _r_reportby = reported_by;
        },
        //maxLength: 10,
      ),
    );
  }
}
