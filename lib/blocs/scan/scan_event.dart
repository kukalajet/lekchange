part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ScanAmountChanged extends ScanEvent {
  const ScanAmountChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ScanAmountDismissed extends ScanEvent {
  const ScanAmountDismissed();
}
