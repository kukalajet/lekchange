import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/scan/scan.dart';
import 'package:lekchange/widgets/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, arguments) {
              final code = barcode.rawValue;
              debugPrint('Barcode found: $code');
              if (code != null) {
                BlocProvider.of<ScanBloc>(context).add(ValueScanned(code));
              }
            },
          ),
          const Center(child: ValueWIP()),
        ],
      ),
    );
  }
}
