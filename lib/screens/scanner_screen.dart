import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/scan/scan.dart';
import 'package:lekchange/widgets/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanBloc, ScanState>(
      listenWhen: (previous, current) => previous.value != current.value,
      listener: (context, state) {
        final value = state.value;
        if (value.isNotEmpty) {
          showCupertinoModalBottomSheet(
            context: context,
            expand: false,
            builder: (context) => ValueWIP(
              key: key,
              value: value,
              onDismiss: () {
                context.read<ScanBloc>().add(const ValueScanned(""));
              },
            ),
          );
        }
      },
      buildWhen: (previous, current) => previous.value != current.value,
      builder: (context, state) {
        final allowDuplicates = state.value.isEmpty;

        return Scaffold(
          body: MobileScanner(
            allowDuplicates: allowDuplicates,
            onDetect: (barcode, arguments) {
              final code = barcode.rawValue;
              if (code != null) {
                BlocProvider.of<ScanBloc>(context).add(ValueScanned(code));
              }
            },
          ),
        );
      },
    );
  }
}
