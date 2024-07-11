import 'package:flutter/material.dart';

class CustomShapeClipperLert extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.618);
    path.lineTo(0, 0);
    path.quadraticBezierTo(size.width * 0.025, size.height * 0.079, size.width * 0.133, size.height * 0.237);
    path.lineTo(size.width * 0.867, size.height * 0.237);
    path.quadraticBezierTo(size.width, size.height * 0.237, size.width, size.height * 0.618);
    path.quadraticBezierTo(size.width, size.height, size.width * 0.867, size.height);
    path.lineTo(size.width * 0.133, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height * 0.618);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomShapeClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height * 0.618);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.975, size.height * 0.079, size.width * 0.867, size.height * 0.237);
    path.lineTo(size.width * 0.133, size.height * 0.237);
    path.quadraticBezierTo(0, size.height * 0.237, 0, size.height * 0.618);
    path.quadraticBezierTo(0, size.height, size.width * 0.133, size.height);
    path.lineTo(size.width * 0.867, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height * 0.618);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}