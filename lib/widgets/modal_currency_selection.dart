import 'package:exchange_repository/exchange_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekchange/blocs/blocs.dart';

class ModalCurrencySelection extends StatelessWidget {
  const ModalCurrencySelection({Key? key}) : super(key: key);

  _buildWhen(ExchangeState previous, ExchangeState current) =>
      previous.currencies != current.currencies ||
      previous.selectedCurrency != current.selectedCurrency ||
      previous.status != current.status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeBloc, ExchangeState>(
      buildWhen: (previous, current) => _buildWhen(previous, current),
      builder: (context, state) {
        return Material(
          child: ListView.builder(
            itemCount: state.currencies.length,
            itemBuilder: (context, index) => CurrencyListItem(
              currency: state.currencies[index],
            ),
          ),
        );
      },
    );
  }
}

class CurrencyListItem extends StatelessWidget {
  const CurrencyListItem({Key? key, required this.currency}) : super(key: key);

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(currency.code, style: textTheme.caption),
        title: Text(currency.name),
        isThreeLine: true,
        subtitle: Text(currency.symbol),
        dense: true,
      ),
    );
  }
}
