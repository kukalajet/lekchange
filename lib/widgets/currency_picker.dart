import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/exchange/exchange.dart';

class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.currencies != current.currencies ||
          previous.selectedCurrency != current.selectedCurrency,
      builder: (context, state) {
        final currencies = state.currencies;
        final selectedCurrency = state.selectedCurrency;

        return SizedBox(
          height: 64.0,
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.horizontal,
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              final name =
                  '${currencies[index].name} ${currencies[index].symbol}';
              final isSelected =
                  currencies[index].code == selectedCurrency.code;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(name),
                  selected: isSelected,
                  selectedColor: Colors.blue,
                  onSelected: (bool _) {
                    context.read<ExchangeBloc>().add(
                        ExchangeSelectedCurrencyChanged(currencies[index]));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
