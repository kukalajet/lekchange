import 'package:flutter/material.dart';

class ValueWIP extends StatelessWidget {
  const ValueWIP({
    Key? key,
    required this.value,
    required this.onDismiss,
  }) : super(key: key);

  final String value;
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            onDismiss();
          },
          child: const Icon(
            Icons.close,
            size: 24,
            color: Colors.black54,
          ),
        ),
        Text(value),
      ],
    );
  }
}
