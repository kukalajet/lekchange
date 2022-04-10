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
    emit(state.copyWith(status: ScanStatus.scanned));
    final value = event.value;
    final url = await _exchangeRepository.retrieveScannedUrl(value);

    final isValid = priceRegExp.hasMatch(url ?? value);
    if (!isValid) {
      emit(state.copyWith(status: ScanStatus.notValid));
      return;
    }

    final index = (url ?? value).indexOf(pricePrefix);
    final substringed = (url ?? value).substring(index + 4);
    final parsed = double.parse(substringed);

    emit(state.copyWith(status: ScanStatus.valid, amount: parsed));
  }

  void _onScanAmountDismissed(
    ScanAmountDismissed event,
    Emitter<ScanState> emit,
  ) {
    emit(state.copyWith(status: ScanStatus.initial, amount: double.nan));
  }
}
