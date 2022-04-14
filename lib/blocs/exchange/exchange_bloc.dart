import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'exchange_state.dart';
part 'exchange_event.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc({required ExchangeRepository exchangeRepository})
      : _exchangeRepository = exchangeRepository,
        super(const ExchangeState()) {
    on<ExchangeValueScanned>(_onExchangeValueScanned);
    on<ExchangeScannedValueDismissed>(_onExchangeScannedValueDismissed);
    on<ExchangeCurrenciesFetched>(_onExchangeCurrenciesFetched);
    on<ExchangeSelectedCurrencyChanged>(_onExchangeSelectedCurrencyChanged);
  }

  final ExchangeRepository _exchangeRepository;

  final _pricePrefix = 'prc=';
  final _priceRegExp = RegExp(r'prc=[0-9.]+');

  void _onExchangeValueScanned(
    ExchangeValueScanned event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(state.copyWith(
      scanStatus: ScanStatus.loading,
      exchangeStatus: ExchangeStatus.loading,
    ));

    try {
      final value = event.value;
      final redirect = await _exchangeRepository.getRedirectUrl(value);

      // `redirect` can be null, we fallback on `value`
      final url = redirect ?? value;

      final isValid = _priceRegExp.hasMatch(url);
      if (!isValid) {
        emit(state.copyWith(
          scanStatus: ScanStatus.success,
          exchangeStatus: ExchangeStatus.failure,
        ));
        return;
      }

      final index = url.indexOf(_pricePrefix);
      final substring = url.substring(index + 4);
      final scannedAmount = double.parse(substring);

      final selectedCurrency = state.selectedCurrency;
      final rate = selectedCurrency.rate;
      final convertedAmount = _convert(scannedAmount, rate);

      emit(state.copyWith(
        scanStatus: ScanStatus.success,
        exchangeStatus: ExchangeStatus.success,
        scannedAmount: scannedAmount,
        convertedAmount: convertedAmount,
      ));
    } catch (_) {
      emit(state.copyWith(
        scanStatus: ScanStatus.failure,
        exchangeStatus: ExchangeStatus.failure,
      ));
    }
  }

  void _onExchangeScannedValueDismissed(
    ExchangeScannedValueDismissed _,
    Emitter<ExchangeState> emit,
  ) {
    emit(state.copyWith(
      exchangeStatus: ExchangeStatus.initial,
      scanStatus: ScanStatus.initial,
    ));
  }

  void _onExchangeCurrenciesFetched(
    ExchangeCurrenciesFetched _,
    Emitter<ExchangeState> emit,
  ) async {
    emit(state.copyWith(exchangeStatus: ExchangeStatus.loading));

    try {
      final currencies = await _exchangeRepository.fetchCurrencies();

      final scannedAmount = state.scannedAmount;
      final defaultCurrency = currencies[0];

      if (scannedAmount.isNaN) {
        emit(state.copyWith(
          currencies: currencies,
          selectedCurrency: defaultCurrency,
          exchangeStatus: ExchangeStatus.success,
        ));
        return;
      }

      final rate = defaultCurrency.rate;
      final convertedAmount = _convert(scannedAmount, rate);

      emit(state.copyWith(
        currencies: currencies,
        selectedCurrency: defaultCurrency,
        convertedAmount: convertedAmount,
        exchangeStatus: ExchangeStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(exchangeStatus: ExchangeStatus.failure));
    }
  }

  void _onExchangeSelectedCurrencyChanged(
    ExchangeSelectedCurrencyChanged event,
    Emitter<ExchangeState> emit,
  ) {
    final selectedCurrency = event.selectedCurrency;
    final rate = selectedCurrency.rate;
    final scannedAmount = state.scannedAmount;
    final convertedAmount = _convert(scannedAmount, rate);

    emit(state.copyWith(
      selectedCurrency: selectedCurrency,
      convertedAmount: convertedAmount,
    ));
  }

  double _convert(double amount, double rate) {
    final converted = amount * rate;
    return converted;
  }
}
