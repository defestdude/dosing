import 'package:flutter/material.dart';

class OnBoardingButtonClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
  
    var controlPoint = Offset(size.height/2, size.width / 2);
    var endPoint = Offset(size.width, size.height);
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    //path.lineTo(size.width -40, size.height -40);
    //path.quadraticBezierTo(endPoint.dy, endPoint.dx, controlPoint.dy, controlPoint.dx);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
