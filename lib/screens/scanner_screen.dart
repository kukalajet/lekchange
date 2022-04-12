import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/exchange/exchange_bloc.dart';
import 'package:lekchange/widgets/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<ExchangeBloc>().add(const ExchangeValueScanned(
    //       "https://efiskalizimi-app.tatime.gov.al/invoice-check/#/verify?iic=A98A8E0A1BBACFE4D6C37669513D1597&tin=L92103036T&crtd=2022-04-05T10:42:15%2B02:00&ord=27029&bu=kk994xz661&cr=jj171xk842&sw=pa302kj223&prc=360.0",
    //     ));
    // context.read<ExchangeBloc>().add(const ExchangeValueScanned("test"));

    return BlocConsumer<ExchangeBloc, ExchangeState>(
      listenWhen: (previous, current) =>
          previous.scanStatus != current.scanStatus,
      listener: (context, state) {
        final isScanned = state.scanStatus == ScanStatus.loading;
        if (isScanned) {
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
          previous.scanStatus != current.scanStatus,
      builder: (context, state) {
        final isScanning = state.scanStatus == ScanStatus.initial;

        return Scaffold(
          body: Stack(
            children: [
              MobileScanner(
                allowDuplicates: isScanning,
                onDetect: (barcode, arguments) {
                  final code = barcode.rawValue;
                  if (code != null) {
                    context
                        .read<ExchangeBloc>()
                        .add(ExchangeValueScanned(code));
                  }
                },
              ),
              ScannerIndicator(visible: isScanning),
            ],
          ),
        );
      },
    );
  }
}
