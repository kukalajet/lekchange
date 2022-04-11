import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';
import 'package:lekchange/blocs/scan/scan.dart';

part 'exchange_state.dart';
part 'exchange_event.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc({
    required ExchangeRepository exchangeRepository,
    required ScanBloc scanBloc,
  })  : _exchangeRepository = exchangeRepository,
        _scanBloc = scanBloc,
        super(const ExchangeState()) {
    on<ExchangeFetched>(_onExchangeFetched);
    on<ExchangeSelectedCurrencyChanged>(_onExchangeSelectedCurrencyChanged);
    on<ExchangeConvertedAmountChanged>(_onExchangeAmountChanged);
    on<ExchangeCurrencyChanged>(_onExchangeCurrencyChanged);
    on<ExchangeStatusChanged>(_onExchangeStatusChanged);
    on<ExchangeStateReset>(_emitExchangeStateReset);

    _scanSubscription = _scanBloc.stream.listen((state) {
      final amount = state.value;
      final status = state.status;

      if (status == ScanStatus.success && !amount.isNaN) {
        add(ExchangeConvertedAmountChanged(amount));
      }
      if (status == ScanStatus.failure) {
        add(const ExchangeStateReset());
        add(const ExchangeStatusChanged(status: ExchangeStatus.failure));
      }
    });
  }

  final ExchangeRepository _exchangeRepository;
  final ScanBloc _scanBloc;
  late StreamSubscription _scanSubscription;

  void _onExchangeFetched(
    ExchangeFetched event,
    Emitter<ExchangeState> emit,
  ) async {
    emit(state.copyWith(status: ExchangeStatus.initial));
    try {
      final currencies = await _exchangeRepository.fetchCurrencies();

      final amount = state.amount;
      final defaultCurrency = currencies[0];
      if (amount.isNaN) {
        emit(state.copyWith(
          currencies: currencies,
          selectedCurrency: defaultCurrency,
          status: ExchangeStatus.success,
        ));
        return;
      }

      final rate = defaultCurrency.rate;
      final converted = _convert(amount, rate).toStringAsFixed(2);

      emit(state.copyWith(
        currencies: currencies,
        selectedCurrency: defaultCurrency,
        status: ExchangeStatus.success,
        converted: converted,
      ));
    } catch (_) {
      add(const ExchangeStateReset());
    }
  }

  void _onExchangeSelectedCurrencyChanged(
    ExchangeSelectedCurrencyChanged event,
    Emitter<ExchangeState> emit,
  ) {
    emit(state.copyWith(selectedCurrency: event.currency));
  }

  void _onExchangeAmountChanged(
    ExchangeConvertedAmountChanged event,
    Emitter<ExchangeState> emit,
  ) {
    try {
      final amount = event.amount;
      final rate = state.selectedCurrency.rate;

      if (rate.isNaN) {
        emit(state.copyWith(amount: amount));
        return;
      }

      if (amount.isNaN) {
        return;
      }

      final converted = _convert(amount, rate).toStringAsFixed(2);
      emit(state.copyWith(amount: amount, converted: converted));
    } catch (_) {
      add(const ExchangeStateReset());
    }
  }

  void _onExchangeCurrencyChanged(
    ExchangeCurrencyChanged event,
    Emitter<ExchangeState> emit,
  ) {
    final currency = event.currency;
    final amount = state.amount;

    if (amount.isNaN) {
      emit(state.copyWith(selectedCurrency: currency));
      return;
    }

    final rate = currency.rate;
    final converted = _convert(amount, rate).toStringAsFixed(2);

    emit(state.copyWith(selectedCurrency: currency, converted: converted));
  }

  void _emitExchangeStateReset(
    ExchangeStateReset event,
    Emitter<ExchangeState> emit,
  ) {
    emit(state.copyWith(
      status: ExchangeStatus.initial,
      amount: double.nan,
      converted: '',
    ));
  }

  void _onExchangeStatusChanged(
    ExchangeStatusChanged event,
    Emitter<ExchangeState> emit,
  ) {
    final status = event.status;

    if (status == ExchangeStatus.failure) {
      emit(state.copyWith(status: status, converted: '🤷🏻'));
      return;
    }

    emit(state.copyWith(status: status));
  }

  @override
  Future<void> close() {
    _scanSubscription.cancel();
    return super.close();
  }

  double _convert(double amount, double rate) {
    final converted = amount * rate;
    return converted;
  }
}
