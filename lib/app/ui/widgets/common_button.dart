//Packages
import 'package:flutter/material.dart';

import '../themes/MyColors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      this.text,
      this.color,
      this.onPressed,
      this.width,
      this.height,
      this.borderRadius = 10.0,
      this.child,
      this.icon,
      this.buttonColor = AppColors.secondaryColor,
      this.fontColor = Colors.white})
      : super(key: key);
  final String? text;
  final Color? color;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? child;
  final IconData? icon;
  final Color? buttonColor;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(borderRadius!),
          color: buttonColor,
          child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 20.0, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                width: width,
                height: height,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     icon==null?
                     const SizedBox(): Icon(
                       icon,
                       size: 20,
                       color: Colors.white,
                     ),
                      Text(
                        text!,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            color: fontColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              onPressed: onPressed),
        ),
      ],
    );
  }
}



class commonButtonSmall extends StatefulWidget {
  const commonButtonSmall({Key? key,
    required this.title,required this.onTap ,this.horizontalPadding=50}) : super(key: key);
  final String title;
  final Function() onTap;
  final double horizontalPadding;
  @override
  State<commonButtonSmall> createState() => _commonButtonSmallState();
}

class _commonButtonSmallState extends State<commonButtonSmall> with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 30;

  double _scaleTransformValue = 1;
  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
      setState(() => _scaleTransformValue = 1 - animationController.value);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
          () => animationController.reverse(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap.call();
        _shrinkButtonSize();
        _restoreButtonSize();
      },
      onTapDown: (_) => _shrinkButtonSize(),
      onTapCancel: _restoreButtonSize,
      child: Transform.scale(
        scale: _scaleTransformValue,
        child: Container(
          decoration: BoxDecoration(
            gradient:
            const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor
                ]
            ),
            color: AppColors.grey.withAlpha(100),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal:20,vertical: 8),
          child: Text(widget.title,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13
            ),
          ),
        ),
      ),

    );
  }
}


class commonButton extends StatefulWidget {
  const commonButton({Key? key,required this.title,required this.onTap ,this.horizontalPadding=40}) : super(key: key);
  final String title;
  final Function() onTap;
  final double horizontalPadding;
  @override
  State<commonButton> createState() => _commonButtonState();
}

class _commonButtonState extends State<commonButton> with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 30;

  double _scaleTransformValue = 1;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
      setState(() => _scaleTransformValue = 1 - animationController.value);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
          () => animationController.reverse(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap.call();
        _shrinkButtonSize();
        _restoreButtonSize();
      },
      onTapDown: (_) => _shrinkButtonSize(),
      onTapCancel: _restoreButtonSize,
      child: Transform.scale(
        scale: _scaleTransformValue,
        child: Container(
        //  width: 135,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor

                ]
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding,vertical: 10),
          child: Center(
            child: Text("${widget.title}",
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17
              ),
            ),
          ),
        ),
      ),
    );
  }
}
