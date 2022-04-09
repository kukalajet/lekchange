import 'package:flutter/rendering.dart';

class ScannerCorner extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.0909091, size.height * 0.5454545);
    path.cubicTo(
      size.width * 0.0826545,
      size.height * 0.4553455,
      size.width * 0.0931818,
      size.height * 0.2714909,
      size.width * 0.1818182,
      size.height * 0.1818182,
    );
    path.cubicTo(
      size.width * 0.2721455,
      size.height * 0.0916000,
      size.width * 0.4544364,
      size.height * 0.0824000,
      size.width * 0.5454545,
      size.height * 0.0909091,
    );
    path.quadraticBezierTo(
      size.width * 0.5819091,
      size.height * 0.0961091,
      size.width * 0.5854545,
      size.height * 0.1363636,
    );
    path.quadraticBezierTo(
      size.width * 0.5821636,
      size.height * 0.1732909,
      size.width * 0.5454545,
      size.height * 0.1818182,
    );
    path.cubicTo(
      size.width * 0.4554364,
      size.height * 0.1812000,
      size.width * 0.3367636,
      size.height * 0.1730545,
      size.width * 0.2454545,
      size.height * 0.2454545,
    );
    path.cubicTo(
      size.width * 0.1742727,
      size.height * 0.3366364,
      size.width * 0.1829455,
      size.height * 0.4553636,
      size.width * 0.1818182,
      size.height * 0.5454545,
    );
    path.quadraticBezierTo(
      size.width * 0.1728727,
      size.height * 0.5820000,
      size.width * 0.1363636,
      size.height * 0.5854545,
    );
    path.quadraticBezierTo(
      size.width * 0.1003818,
      size.height * 0.5836000,
      size.width * 0.0909091,
      size.height * 0.5454545,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
