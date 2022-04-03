part of 'scan_bloc.dart';

enum ScanStatus { initial, valid, notValid }

class ScanState extends Equatable {
  const ScanState({
    this.status = ScanStatus.initial,
    this.value = double.nan,
  });

  final double value;
  final ScanStatus status;

  ScanState copyWith({ScanStatus? status, double? value, Currency? currency}) {
    return ScanState(
      status: status ?? this.status,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return '''ScanState { status: $status, value: $value }''';
  }

  @override
  List<Object> get props => [status, value];
}
