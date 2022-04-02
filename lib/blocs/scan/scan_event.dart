part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ScanValueChanged extends ScanEvent {
  const ScanValueChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ScanValueDismissed extends ScanEvent {
  const ScanValueDismissed();
}
