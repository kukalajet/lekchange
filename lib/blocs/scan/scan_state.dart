part of 'scan_bloc.dart';

enum ScanStatus { initial, loading, success, failure }

class ScanState extends Equatable {
  const ScanState({
    this.value = double.nan,
    this.status = ScanStatus.initial,
  });

  final double value;
  final ScanStatus status;

  ScanState copyWith({
    double? value,
    ScanStatus? status,
  }) {
    return ScanState(
      value: value ?? this.value,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return '''ScanState { amount: $value, status: $status }''';
  }

  @override
  List<Object> get props => [value, status];
}
