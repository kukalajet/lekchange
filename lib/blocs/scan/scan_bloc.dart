import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scan_state.dart';
part 'scan_event.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(const ScanState()) {
    on<ValueScanned>(_onValueScanned);
  }

  void _onValueScanned(ValueScanned event, Emitter<ScanState> emit) {
    final value = event.value;
    emit(state.copyWith(status: ScanStatus.success, value: value));
  }
}
