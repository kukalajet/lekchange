part of 'exchange_bloc.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();

  @override
  List<Object> get props => [];
}

class ExchangeFetched extends ExchangeEvent {}

class ExchangeSelectedCurrencyChanged extends ExchangeEvent {
  const ExchangeSelectedCurrencyChanged(this.currency);

  final Currency currency;

  @override
  List<Object> get props => [currency];
}

class ExchangeConvertedValueChanged extends ExchangeEvent {
  const ExchangeConvertedValueChanged(this.value);

  final double value;

  @override
  List<Object> get props => [value];
}
