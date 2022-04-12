part of 'exchange_bloc.dart';

enum ExchangeStatus { initial, loading, success, failure }
enum ScanStatus { initial, loading, success, failure }

class ExchangeState extends Equatable {
  const ExchangeState({
    this.exchangeStatus = ExchangeStatus.initial,
    this.scanStatus = ScanStatus.initial,
    this.scannedAmount = double.nan,
    this.convertedAmount = double.nan,
    this.selectedCurrency = Currency.empty,
    this.currencies = const <Currency>[],
  });

  final ExchangeStatus exchangeStatus;
  final ScanStatus scanStatus;
  final double scannedAmount;
  final double convertedAmount;
  final Currency selectedCurrency;
  final List<Currency> currencies;

  ExchangeState copyWith({
    ExchangeStatus? exchangeStatus,
    ScanStatus? scanStatus,
    double? scannedAmount,
    double? convertedAmount,
    Currency? selectedCurrency,
    List<Currency>? currencies,
  }) {
    return ExchangeState(
      exchangeStatus: exchangeStatus ?? this.exchangeStatus,
      scanStatus: scanStatus ?? this.scanStatus,
      scannedAmount: scannedAmount ?? this.scannedAmount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencies: currencies ?? this.currencies,
    );
  }

  @override
  String toString() {
    return '''ExchangeState { exchangeStatus: $exchangeStatus, scanStatus: $scanStatus, scannedAmount: $scannedAmount, convertedAmount: $convertedAmount, selectedCurrency: $selectedCurrency, currencies: $currencies }''';
  }

  @override
  List<Object> get props => [
        exchangeStatus,
        scanStatus,
        scannedAmount,
        convertedAmount,
        selectedCurrency,
        currencies
      ];
}
