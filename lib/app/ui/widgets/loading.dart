import 'package:flutter/material.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({Key? key}) : super(key: key);

  @override
  LogoAnimationState createState() => LogoAnimationState();
}
class LogoAnimationState extends State<LogoAnimation> with TickerProviderStateMixin {

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
        duration: const Duration(seconds: 7),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            RotationTransition(
                turns:_controller,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Image.asset('assets/images/clockwise_image.png')
                    ]
                )
            ),
            RotationTransition(
                turns:turnsTween.animate(_controller),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Image.asset('assets/images/anti_clockwise_image.png')
                    ]
                )
            ),

            SizedBox(
                child: Center(
                  child: Image.asset('assets/images/centered_logo.png'),
                )),

          ],
        ),
      ),
    );
  }
}