import 'package:flutter/material.dart';
import 'package:lekchange/widgets/scanner_corner.dart';

class ScannerIndicator extends StatelessWidget {
  const ScannerIndicator({Key? key, required this.visible}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: visible ? 1.0 : 0.0,
      child: Column(
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
      ),
    );
  }
}

enum Position { topRight, topLeft, bottomRight, bottomLeft }

class Corner extends StatefulWidget {
  const Corner({Key? key, required this.position}) : super(key: key);

  final Position position;

  @override
  State<Corner> createState() => _CornerState();
}

class _CornerState extends State<Corner> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void _addListener() => setState(() {});

  void _addStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 100,
      end: 105,
    ).animate(controller)
      ..addListener(_addListener)
      ..addStatusListener(_addStatusListener);

    controller.forward();
  }

  double _getPositionValue() {
    if (widget.position == Position.topLeft) return 60 / 60;
    if (widget.position == Position.topRight) return 15 / 60;
    if (widget.position == Position.bottomRight) return 30 / 60;
    if (widget.position == Position.bottomLeft) return 45 / 60;
    return 60 / 60;
  }

  @override
  Widget build(BuildContext context) {
    final position = _getPositionValue();

    return RotationTransition(
      turns: AlwaysStoppedAnimation(position),
      child: ClipPath(
        child: Container(
          width: animation.value,
          height: animation.value,
          color: Colors.white,
        ),
        clipper: ScannerCorner(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
