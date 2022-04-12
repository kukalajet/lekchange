part of 'exchange_bloc.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();

  @override
  List<Object> get props => [];
}

class ExchangeValueScanned extends ExchangeEvent {
  const ExchangeValueScanned(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ExchangeScannedValueDismissed extends ExchangeEvent {
  const ExchangeScannedValueDismissed();

  @override
  List<Object> get props => [];
}

class ExchangeCurrenciesFetched extends ExchangeEvent {
  const ExchangeCurrenciesFetched();

  @override
  List<Object> get props => [];
}

class ExchangeSelectedCurrencyChanged extends ExchangeEvent {
  const ExchangeSelectedCurrencyChanged(this.selectedCurrency);

  final Currency selectedCurrency;

  @override
  List<Object> get props => [];
}
