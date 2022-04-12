import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/blocs.dart';
import 'currency_picker.dart';

class ScannerModalContent extends StatelessWidget {
  const ScannerModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Header(),
            Body(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  void _onDismiss(BuildContext context) {
    Navigator.of(context).pop();
    context.read<ExchangeBloc>().add(const ExchangeScannedValueDismissed());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          ElevatedButton(
            onPressed: () => _onDismiss(context),
            child: const Icon(
              Icons.close_sharp,
              color: Colors.black54,
              size: 24,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.exchangeStatus != current.exchangeStatus,
      builder: (context, state) {
        final isLoading = state.exchangeStatus == ExchangeStatus.loading;

        if (isLoading) {
          return const SizedBox(
            height: 192.0,
            child: SizedBox(
              height: 40.0,
              width: 40.0,
              child: FittedBox(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return SizedBox(
          height: 192.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Amount(),
              BottomMessage(),
            ],
          ),
        );
      },
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.exchangeStatus != current.exchangeStatus,
      builder: (context, state) {
        final ready = state.exchangeStatus == ExchangeStatus.success;

        if (!ready) {
          return const SizedBox(height: 64.0);
        }

        return const CurrencyPicker();
      },
    );
  }
}

class Amount extends StatelessWidget {
  const Amount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.convertedAmount != current.convertedAmount ||
          previous.selectedCurrency != current.selectedCurrency,
      builder: (context, state) {
        final exchangeStatus = state.exchangeStatus;
        final convertedAmount = state.convertedAmount.toStringAsFixed(2);
        final selectedCurrencySymbol = state.selectedCurrency.symbol;
        final formatedAmount = '$convertedAmount $selectedCurrencySymbol';

        final value =
            exchangeStatus != ExchangeStatus.failure ? formatedAmount : "🤷🏻";

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            value,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 64.0,
            ),
          ),
        );
      },
    );
  }
}

class BottomMessage extends StatelessWidget {
  const BottomMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.scannedAmount != current.scannedAmount ||
          previous.selectedCurrency != current.selectedCurrency,
      builder: (context, state) {
        final isValid = state.exchangeStatus == ExchangeStatus.success;
        final scannedAmount = state.scannedAmount.toStringAsFixed(2);
        final formattedAmount = '$scannedAmount Lekë';
        final value = isValid
            ? formattedAmount
            : "Wrong QR code.\nAre you sure you are scanning a valid receipt?";

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            value,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w300,
              fontSize: 18.0,
            ),
          ),
        );
      },
    );
  }
}
