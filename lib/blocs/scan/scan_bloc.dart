import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ExchangeRepository exchangeRepository;

  ScanBloc({required this.exchangeRepository}) : super(const ScanState()) {
    on<ScanValueChanged>(_onScanValueChanged);
    on<ScanValueDismissed>(_onScanValueDismissed);
  }

  void _onScanValueChanged(ScanValueChanged event, Emitter<ScanState> emit) {
    final value = event.value;
    emit(state.copyWith(status: ScanStatus.success, value: value));
  }

  void _onScanValueDismissed(
    ScanValueDismissed event,
    Emitter<ScanState> emit,
  ) {
    emit(state.copyWith(status: ScanStatus.initial, value: ''));
  }
}
