import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/scan/scan.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      buildWhen: (previous, current) => previous.value != current.value,
      builder: (context, state) {
        final value = state.value;

        return Text(value, maxLines: 3);
      },
    );
  }
}
