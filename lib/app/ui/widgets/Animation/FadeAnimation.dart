// import 'package:flutter/animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get_utils/src/extensions/num_extensions.dart';
// import 'package:sofproject/app/ui/widgets/Animation/multi_tween.dart';
// import 'package:sofproject/app/ui/widgets/Animation/play_animation.dart';
// import 'package:simple_animations/simple_animations.dart';
// enum AniProps { opacity, translateY }
// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;
//
//   FadeAnimation(this.delay, this.child, {AssetImage? image});
//
//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTween<AniProps>()
//       ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0), 500.milliseconds)
//       ..add(AniProps.translateY, Tween(begin: 130.0, end: 0.0), 500.milliseconds,
//           Curves.easeOut);
//     return PlayAnimation<MultiTweenValues<AniProps>>(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builder: (context, child, value) => Opacity(
//         opacity: value.get(AniProps.opacity),
//         child: Transform.translate(
//             offset: Offset(0, value.get(AniProps.translateY)), child: child),
//       ),
//     );
//   }
// }