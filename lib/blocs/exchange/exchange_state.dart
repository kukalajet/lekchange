part of 'exchange_bloc.dart';

enum ExchangeStatus { initial, success, failure }
enum ConvertionStatus { initial, success, failure }

class ExchangeState extends Equatable {
  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.selectedCurrency = Currency.empty,
    this.currencies = const <Currency>[],
    this.amount = double.nan,
    this.converted = '',
  });

  final ExchangeStatus status;
  final Currency selectedCurrency;
  final List<Currency> currencies;
  final double amount;
  final String converted;

  ExchangeState copyWith({
    ExchangeStatus? status,
    Currency? selectedCurrency,
    List<Currency>? currencies,
    double? amount,
    String? converted,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencies: currencies ?? this.currencies,
      amount: amount ?? this.amount,
      converted: converted ?? this.converted,
    );
  }

  @override
  String toString() {
    return '''ExchangeState { status: $status, selectedCurrency: $selectedCurrency, currencies: $currencies, amount: $amount, converted: $converted }''';
  }

  @override
  List<Object> get props => [
        status,
        selectedCurrency,
        currencies,
        amount,
        converted,
      ];
}
