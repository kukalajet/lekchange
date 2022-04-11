import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final pricePrefix = 'prc=';
  final priceRegExp = RegExp(r'prc=[0-9.]+');

  ScanBloc({required ExchangeRepository exchangeRepository})
      : _exchangeRepository = exchangeRepository,
        super(const ScanState()) {
    on<ScanAmountChanged>(_onScanAmountChanged);
    on<ScanAmountDismissed>(_onScanAmountDismissed);
  }

  final ExchangeRepository _exchangeRepository;

  void _onScanAmountChanged(
    ScanAmountChanged event,
    Emitter<ScanState> emit,
  ) async {
    emit(state.copyWith(status: ScanStatus.loading));
    final value = event.value;
    final fetched = await _exchangeRepository.fetchUrl(value);

    // `fetched` can be null, we fallback on `value`
    final url = fetched ?? value;

    final isValid = priceRegExp.hasMatch(url);
    if (!isValid) {
      emit(state.copyWith(status: ScanStatus.failure, value: double.nan));
      return;
    }

    final index = url.indexOf(pricePrefix);
    final substringed = url.substring(index + 4);
    final parsed = double.parse(substringed);

    emit(state.copyWith(status: ScanStatus.success, value: parsed));
  }

  void _onScanAmountDismissed(
    ScanAmountDismissed event,
    Emitter<ScanState> emit,
  ) {
    emit(state.copyWith(status: ScanStatus.initial, value: double.nan));
  }
}
