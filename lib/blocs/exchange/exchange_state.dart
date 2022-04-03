part of 'exchange_bloc.dart';

enum ExchangeStatus { initial, success, failure }
enum ConvertionStatus { initial, success, failure }

class ExchangeState extends Equatable {
  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.selectedCurrency = Currency.empty,
    this.currencies = const <Currency>[],
    this.converted = '',
  });

  final ExchangeStatus status;
  final Currency selectedCurrency;
  final List<Currency> currencies;
  final String converted;

  ExchangeState copyWith({
    ExchangeStatus? status,
    Currency? selectedCurrency,
    List<Currency>? currencies,
    String? converted,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencies: currencies ?? this.currencies,
      converted: converted ?? this.converted,
    );
  }

  @override
  String toString() {
    return '''ExchangeState { status: $status, selectedCurrency: $selectedCurrency, currencies: $currencies, converted: $converted }''';
  }

  @override
  List<Object> get props => [status, selectedCurrency, currencies, converted];
}
