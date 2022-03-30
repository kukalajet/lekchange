part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object> get props => [];
}

class ValueScanned extends ScanEvent {
  const ValueScanned(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
