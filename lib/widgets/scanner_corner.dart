import 'package:flutter/rendering.dart';

class ScannerCorner extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.1111111, size.height * 0.8333333);
    path.lineTo(size.width * 0.1222222, size.height * 0.8777778);
    path.lineTo(size.width * 0.1666667, size.height * 0.8888889);
    path.lineTo(size.width * 0.2111111, size.height * 0.8777778);
    path.lineTo(size.width * 0.2222222, size.height * 0.8111111);
    path.lineTo(size.width * 0.2177778, size.height * 0.6888889);
    path.lineTo(size.width * 0.2222222, size.height * 0.5333333);
    path.lineTo(size.width * 0.2444444, size.height * 0.4222222);
    path.lineTo(size.width * 0.3111111, size.height * 0.3111111);
    path.lineTo(size.width * 0.4222222, size.height * 0.2444444);
    path.lineTo(size.width * 0.5333333, size.height * 0.2222222);
    path.lineTo(size.width * 0.6888889, size.height * 0.2177778);
    path.lineTo(size.width * 0.8111111, size.height * 0.2222222);
    path.lineTo(size.width * 0.8777778, size.height * 0.2111111);
    path.lineTo(size.width * 0.8888889, size.height * 0.1666667);
    path.lineTo(size.width * 0.8777778, size.height * 0.1222222);
    path.lineTo(size.width * 0.8333333, size.height * 0.1111111);
    path.lineTo(size.width * 0.6444444, size.height * 0.1111111);
    path.lineTo(size.width * 0.4555556, size.height * 0.1222222);
    path.lineTo(size.width * 0.3444444, size.height * 0.1555556);
    path.lineTo(size.width * 0.2333333, size.height * 0.2333333);
    path.lineTo(size.width * 0.1555556, size.height * 0.3444444);
    path.lineTo(size.width * 0.1222222, size.height * 0.4555556);
    path.lineTo(size.width * 0.1111111, size.height * 0.6444444);
    path.lineTo(size.width * 0.1111111, size.height * 0.8333333);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
