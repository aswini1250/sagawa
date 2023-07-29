import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurvedPopup extends StatelessWidget {
  final Widget child;

  const CurvedPopup({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipPath(
        clipper: _CurvedClipper(),
        child: Container(
          height: Get.height*0.6,
          width: Get.width*0.7,
          child: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  child: child),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.close,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double radius = 10.0;

    path.lineTo(0, size.height - radius);

    path.quadraticBezierTo(
      0,
      size.height,
      radius,
      size.height,
    );

    path.lineTo(size.width - radius, size.height);

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );

    path.lineTo(size.width, radius);

    path.quadraticBezierTo(
      size.width,
      0,
      size.width - radius,
      0,
    );

    path.lineTo(radius, 0);

    path.quadraticBezierTo(
      0,
      0,
      0,
      radius,
    );

    return path;
  }

  @override
  bool shouldReclip(_CurvedClipper oldClipper) => false;
}