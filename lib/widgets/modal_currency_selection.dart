import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/blocs.dart';

class ModalCurrencySelection extends StatelessWidget {
  const ModalCurrencySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      buildWhen: (previous, current) => previous.value != current.value,
      builder: (context, state) {
        return Material(
          child: Container(
            height: 25,
          ),
        );
      },
    );
  }
}
