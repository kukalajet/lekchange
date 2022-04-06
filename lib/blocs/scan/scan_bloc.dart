import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_repository/exchange_repository.dart';

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final pricePrefix = 'prc=';
  final priceRegExp = RegExp(r'prc=[0-9.]+');

  ScanBloc() : super(const ScanState()) {
    on<ScanAmountChanged>(_onScanAmountChanged);
    on<ScanAmountDismissed>(_onScanAmountDismissed);
  }

  void _onScanAmountChanged(ScanAmountChanged event, Emitter<ScanState> emit) {
    final amount = event.amount;
    final isValid = priceRegExp.hasMatch(amount);
    if (!isValid) {
      emit(state.copyWith(status: ScanStatus.notValid));
      return;
    }

    final index = amount.indexOf(pricePrefix);
    final substringed = amount.substring(index + 4);
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
