import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/blocs.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      buildWhen: (previous, current) => previous.value != current.value,
      builder: (context, state) {
        final value = state.value;

        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              Header(
                onDismiss: () {
                  Navigator.of(context).pop();
                  context.read<ScanBloc>().add(const ScanValueDismissed());
                },
              ),
              Body(value: value),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.onDismiss}) : super(key: key);

  final Function() onDismiss;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        ElevatedButton(
          onPressed: onDismiss,
          child: const Icon(
            Icons.close_sharp,
            color: Colors.black54,
            size: 24,
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[300],
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 48.0),
      width: double.infinity,
      child: Text(
        value,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 48,
        ),
      ),
    );
  }
}