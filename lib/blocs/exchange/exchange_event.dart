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

class ExchangeConvertedAmountChanged extends ExchangeEvent {
  const ExchangeConvertedAmountChanged(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

class ExchangeCurrencyChanged extends ExchangeEvent {
  const ExchangeCurrencyChanged(this.currency);

  final Currency currency;

  @override
  List<Object> get props => [currency];
}

class ExchangeStatusChanged extends ExchangeEvent {
  const ExchangeStatusChanged({required this.status});

  final ExchangeStatus status;

  @override
  List<Object> get props => [];
}

class ExchangeStateReset extends ExchangeEvent {
  const ExchangeStateReset();

  @override
  List<Object> get props => [];
}
