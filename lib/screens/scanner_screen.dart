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
    context.read<ScanBloc>().add(const ScanAmountChanged(
          "https://efiskalizimi-app.tatime.gov.al/invoice-check/#/verify?iic=A98A8E0A1BBACFE4D6C37669513D1597&tin=L92103036T&crtd=2022-04-05T10:42:15%2B02:00&ord=27029&bu=kk994xz661&cr=jj171xk842&sw=pa302kj223&prc=360.0",
        ));

    return BlocConsumer<ScanBloc, ScanState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          previous.amount != current.amount,
      listener: (context, state) {
        final amount = state.amount;
        if (!amount.isNaN) {
          showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            isDismissible: false,
            enableDrag: false,
            builder: (context) => ScannerModalContent(key: key),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status &&
          previous.amount != current.amount,
      builder: (context, state) {
        final allowDuplicates = state.status == ScanStatus.initial;
        final isScannerIndicatorVisible = state.amount.isNaN;

        return Scaffold(
          body: Stack(
            children: [
              MobileScanner(
                allowDuplicates: allowDuplicates,
                onDetect: (barcode, arguments) {
                  final code = barcode.rawValue;
                  if (code != null) {
                    context.read<ScanBloc>().add(ScanAmountChanged(code));
                  }
                },
              ),
              ScannerIndicator(visible: isScannerIndicatorVisible),
            ],
          ),
        );
      },
    );
  }
}
