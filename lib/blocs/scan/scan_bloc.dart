import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ExchangeRepository exchangeRepository;

  final pricePrefix = 'prc=';
  final priceRegExp = RegExp(r'prc=[0-9.]+');

  ScanBloc({required this.exchangeRepository}) : super(const ScanState()) {
    on<ScanValueChanged>(_onScanValueChanged);
    on<ScanValueDismissed>(_onScanValueDismissed);
  }

  void _onScanValueChanged(ScanValueChanged event, Emitter<ScanState> emit) {
    final scanned = event.value;
    final isValid = priceRegExp.hasMatch(scanned);
    if (!isValid) {
      emit(state.copyWith(status: ScanStatus.notValid, value: scanned));
      return;
    }

    final index = scanned.indexOf(pricePrefix);
    final value = scanned.substring(index + 4);

    emit(state.copyWith(status: ScanStatus.valid, value: value));
  }

  void _onScanValueDismissed(
    ScanValueDismissed event,
    Emitter<ScanState> emit,
  ) {
    emit(state.copyWith(status: ScanStatus.initial, value: ''));
  }
}
