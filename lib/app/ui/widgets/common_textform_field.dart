import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/MyColors.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({
    Key? key,
    required this.validator,
    this.lableText,
    this.enabled = true,
    this.hintText,
    this.password = false,
    this.maxLength,
    this.keyboardType,
    this.controller,
    this.phoneCode = false,
    this.errorText,
    this.maxlines,
    this.child,
    this.onChanged,
    this.textinputaction,
    this.focusnode,
    this.onSubmitted, this.inputFormatters, this.textSize, this.hintTextSize, this.textStyleHeight,
  }) : super(key: key);

  final String? lableText;
  final String? hintText;
  final String? errorText;
  final bool? password;
  final int? maxLength;
  final double? textStyleHeight;
  final double? textSize;
  final double? hintTextSize;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final bool? phoneCode;
  final int? maxlines;
  final Widget? child;
  final bool enabled;
  final Function(String?)? onChanged;
  final textinputaction;
  final focusnode;
  final Function()? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;


  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        focusNode: widget.focusnode,
        textInputAction: widget.textinputaction,
        enabled: widget.enabled,
        cursorColor: AppColors.primaryColor,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        maxLines: widget.maxlines,
        validator: widget.validator,
        style:  TextStyle(
            height:widget.textStyleHeight,
            fontSize: widget.textSize,
            color: AppColors.primaryColor, fontWeight: FontWeight.w400),
        onFieldSubmitted: (data) {
          //widget.onSubmitted!();
        },
        onChanged: (data) {
          if(data!=null){
            if(widget.onChanged!=null) {
              if (data == "") {
                widget.onChanged!("");
              } else {
                widget.onChanged!(data);
              }
            }
          }
        },
        decoration: InputDecoration(
            labelText: widget.lableText,
            hintText: widget.hintText,
            counterText: "",
            alignLabelWithHint: true,
            hintStyle: TextStyle(
              fontSize: widget.hintTextSize,
              color: AppColors.primaryColor.withAlpha(110),
            ),
            labelStyle: TextStyle(fontSize: 12,color: AppColors.primaryColor.withAlpha(250)),
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
              child: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryColor,
              ),
            )
                : const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            fillColor: Colors.purple),
        obscureText: widget.password == true ? !passwordVisible : false,
      ),
    );
  }
}
