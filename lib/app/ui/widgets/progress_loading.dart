import 'package:flutter/material.dart';

import '../themes/MyColors.dart';

class ProgressLoading extends StatefulWidget {
  final double? progressRadius;
  final double? logoSize;
  final double? loadingRadius;
  final String title;
  final Color color;
  const ProgressLoading({Key? key,
    this.color=AppColors.primaryColor,
    this.title="",this.progressRadius=30,this.logoSize=19,this.loadingRadius=45}) : super(key: key);

  @override
  ProgressLoadingState createState() => ProgressLoadingState();
}
class ProgressLoadingState extends State<ProgressLoading> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _animation.removeStatusListener((status) { });
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        value: 0.25,
        lowerBound: 0.25,
        upperBound: 0.5
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.forward();
    _controller.repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height:widget.progressRadius,
          width:widget.progressRadius,
          child: CircularProgressIndicator(
            color: widget.color,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            strokeWidth: 1.5,
          ),
        ),
        widget.title==""?
        SizedBox():SizedBox(height: 20,),
        widget.title==""?
        SizedBox():Text("${widget.title}",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16
          ),)
      ],
    );
  }
}