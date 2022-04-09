import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/blocs.dart';
import 'package:lekchange/widgets/widgets.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({Key? key}) : super(key: key);

  Widget _buildBody(
    String value,
    String currency,
    bool loaded,
  ) {
    if (!loaded) return const CircularProgressIndicator();
    return Column(
      children: [
        Value(value: value, currency: currency),
        const CurrencyPicker(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.converted != current.converted ||
          previous.status != current.status ||
          previous.selectedCurrency != current.selectedCurrency,
      builder: (context, state) {
        final value = state.converted;
        final currency = state.selectedCurrency.symbol;
        final loaded = state.status == ExchangeStatus.success;

        return Material(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(
                  onDismiss: () {
                    Navigator.of(context).pop();
                    context.read<ScanBloc>().add(const ScanAmountDismissed());
                  },
                ),
                _buildBody(value, currency, loaded),
              ],
            ),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
            ),
          ),
        ],
      ),
    );
  }
}

class Value extends StatelessWidget {
  const Value({
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
