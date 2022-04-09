import 'package:flutter/material.dart';
import 'package:lekchange/widgets/scanner_corner.dart';

class ScannerIndicator extends StatelessWidget {
  const ScannerIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Corner(position: Position.topLeft),
            Corner(position: Position.topRight),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Corner(position: Position.bottomLeft),
            Corner(position: Position.bottomRight),
          ],
        ),
      ],
    );
  }
}

enum Position { topRight, topLeft, bottomRight, bottomLeft }

class Corner extends StatelessWidget {
  const Corner({Key? key, required this.position}) : super(key: key);

  final Position position;

  double _getPositionValue() {
    if (position == Position.topLeft) return 60 / 60;
    if (position == Position.topRight) return 15 / 60;
    if (position == Position.bottomRight) return 30 / 60;
    if (position == Position.bottomLeft) return 45 / 60;
    return 60 / 60;
  }

  @override
  Widget build(BuildContext context) {
    final position = _getPositionValue();
    final side = MediaQuery.of(context).size.width * 0.25;

    return RotationTransition(
      turns: AlwaysStoppedAnimation(position),
      child: ClipPath(
        child: Container(
          width: side,
          height: side,
          color: Colors.red,
        ),
        clipper: ScannerCorner(),
      ),
    );
  }
}
