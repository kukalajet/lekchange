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
    context.read<ScanBloc>().add(const ScanAmountDismissed());
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
          previous.converted != current.converted ||
          previous.selectedCurrency != current.selectedCurrency ||
          previous.status != current.status,
      builder: (context, state) {
        final value = state.converted;
        final currency = state.selectedCurrency.symbol;
        final ready = state.status == ExchangeStatus.success;

        if (!ready) {
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
            children: [
              Amount(value: value, currency: currency),
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final ready = state.status == ExchangeStatus.success;

        if (!ready) {
          return const SizedBox(height: 64.0);
        }

        return const CurrencyPicker();
      },
    );
  }
}

class Amount extends StatelessWidget {
  const Amount({
    Key? key,
    required this.value,
    required this.currency,
  }) : super(key: key);

  final String value;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      width: double.infinity,
      child: Text(
        "$value $currency",
        maxLines: 3,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 56.0,
        ),
      ),
    );
  }
}
