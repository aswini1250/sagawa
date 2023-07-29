import 'package:erp/app/ui/themes/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormManPowerField extends StatefulWidget {
  const CommonTextFormManPowerField(
      {Key? key,
        required this.validator,
        this.lableText,
        this.hintText,
        this.password = false,
        this.maxLength,
        this.keyboardType,
        this.controller,
        this.phoneCode = false,
        this.errorText,
        this.maxlines=1,
        this.enable=true,
        this.inputFormatters,
        this.isWhiteColors=false,
        this.order,
        this.width=270,
        this.isDatePicker=false,
        this.child,  this.onTap,

      this.onChanged})
      : super(key: key);

  final String? lableText;
  final String? hintText;
  final String? errorText;
  final bool? password;
  final double width;
  final bool? isDatePicker;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?) validator;
  final bool? phoneCode;
  final int? maxlines;
  final Widget? child;

  final bool isWhiteColors;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool enable;
final double? order;

  @override
  State<CommonTextFormManPowerField> createState() => _CommonTextFormManPowerFieldState();
}

class _CommonTextFormManPowerFieldState extends State<CommonTextFormManPowerField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: GestureDetector(
        onTap: (){
          if(widget.isDatePicker==true){
            widget.onTap!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          child: TextFormField(
           onTap: (){
             widget.onTap!();
           },
            onChanged: (data){
              widget.onChanged!(data);
            },
            readOnly:widget.isDatePicker==true? true:false,
            inputFormatters: widget.inputFormatters,
           cursorColor: widget.isWhiteColors==true?

           AppColors.white:
           AppColors.primaryColor,
           controller: widget.controller,
           keyboardType: widget.keyboardType,
            enabled: widget.enable,
           maxLength: widget.maxLength,
           maxLines: widget.maxlines,
           validator: widget.validator,
           style:  TextStyle(
               color: widget.isWhiteColors==true?
               AppColors.white:
               AppColors.primaryColor,
               fontWeight: FontWeight.w400
           ),
           decoration: InputDecoration(
             labelText: widget.lableText,
             alignLabelWithHint: true,
             hintText: widget.hintText,
             isDense: true,                      // Added this
             contentPadding: EdgeInsets.all(8),  // Added this
             hintStyle:
             TextStyle(color: widget.isWhiteColors==true?
             AppColors.white.withAlpha(150):
             AppColors.primaryColor.withAlpha(150),fontSize: 15),
             labelStyle:
             TextStyle(color: widget.isWhiteColors==true?
             AppColors.white.withAlpha(200):
             AppColors.primaryColor.withAlpha(200),fontSize: 15),
             errorText: widget.errorText,
             suffixIcon: widget.password == true
                 ? InkWell(
               onTap: () {
                 setState(
                       () {
                     passwordVisible = !passwordVisible;
                   },
                 );
               },
               child: Icon(!passwordVisible
                   ? Icons.visibility
                   : Icons.visibility_off,
                   color:widget.isWhiteColors==true?
                   AppColors.white:
                   AppColors.primaryColor),
             )
                 : const SizedBox(),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(8),

             ),
             focusedBorder:  OutlineInputBorder(
               borderRadius:  BorderRadius.circular(8),
               borderSide:  BorderSide(color: widget.isWhiteColors==true?
               AppColors.white:
               AppColors.primaryColor,width: 1.7 ),

             ),
             disabledBorder:  OutlineInputBorder(
               borderRadius:  BorderRadius.circular(8),
           borderSide:  BorderSide(color: widget.isWhiteColors==true?
           AppColors.white:
           AppColors.primaryColor,width: 1 ),

            ),
             enabledBorder:  OutlineInputBorder(
               borderRadius:  BorderRadius.circular(8),
               borderSide:  BorderSide(color:widget.isWhiteColors==true?
               AppColors.white:
               AppColors.primaryColor,width: 1 ),

             ),

             fillColor: widget.isWhiteColors==true?
             AppColors.white:
             AppColors.primaryColor,),
           obscureText:
           widget.password==true?
           !passwordVisible:false,
            ),
        ),
      ),
    );
  }
}
