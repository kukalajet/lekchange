part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ScanAmountChanged extends ScanEvent {
  const ScanAmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

class ScanAmountDismissed extends ScanEvent {
  const ScanAmountDismissed();
}
