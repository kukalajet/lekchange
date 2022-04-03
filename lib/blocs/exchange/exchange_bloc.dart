import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'exchange_state.dart';
part 'exchange_event.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepository exchangeRepository;

  ExchangeBloc({
    required this.exchangeRepository,
  }) : super(const ExchangeState()) {
    on<ExchangeFetched>(_onExchangeFetched);
    on<ExchangeSelectedCurrencyChanged>(_onExchangeSelectedCurrencyChanged);
  }

  void _onExchangeFetched(
    ExchangeFetched event,
    Emitter<ExchangeState> emit,
  ) async {
    try {
      final currencies = await exchangeRepository.fetchCurrencies();
      emit(state.copyWith(currencies: currencies));
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
}
