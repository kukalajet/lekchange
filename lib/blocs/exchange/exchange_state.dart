part of 'exchange_bloc.dart';

enum ExchangeStatus { initial, success, failure }

class ExchangeState extends Equatable {
  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.selectedCurrency = Currency.empty,
    this.currencies = const <Currency>[],
  });

  final ExchangeStatus status;
  final Currency selectedCurrency;
  final List<Currency> currencies;

  ExchangeState copyWith({
    ExchangeStatus? status,
    Currency? selectedCurrency,
    List<Currency>? currencies,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencies: currencies ?? this.currencies,
    );
  }

  @override
  String toString() {
    return '''ExchangeState { status: $status, selectedCurrency: $selectedCurrency, currencies: $currencies }''';
  }

  @override
  List<Object> get props => [status, selectedCurrency, currencies];
}
