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
    on<ExchangeConvertedValueChanged>(_onExchangeValueChanged);

    _scanSubscription = _scanBloc.stream.listen((event) {
      final value = event.value;
      if (!value.isNaN) {
        add(ExchangeConvertedValueChanged(value));
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
    try {
      final currencies = await _exchangeRepository.fetchCurrencies();
      emit(state.copyWith(
        currencies: currencies,
        selectedCurrency: currencies[0],
      ));
    } catch (_) {
      emit(state.copyWith(status: ExchangeStatus.failure));
    }
  }

  void _onExchangeSelectedCurrencyChanged(
    ExchangeSelectedCurrencyChanged event,
    Emitter<ExchangeState> emit,
  ) {
    emit(state.copyWith(selectedCurrency: event.currency));
  }

  void _onExchangeValueChanged(
    ExchangeConvertedValueChanged event,
    Emitter<ExchangeState> emit,
  ) {
    try {
      final value = event.value;
      final rate = state.selectedCurrency.rate;
      final converted = value * rate;
      emit(state.copyWith(converted: converted.toStringAsFixed(2)));
    } catch (_) {
      print("TODO");
    }
  }

  @override
  Future<void> close() {
    _scanSubscription.cancel();
    return super.close();
  }
}
