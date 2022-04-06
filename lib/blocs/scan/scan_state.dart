part of 'scan_bloc.dart';

enum ScanStatus { initial, valid, notValid }

class ScanState extends Equatable {
  const ScanState({
    this.status = ScanStatus.initial,
    this.amount = double.nan,
  });

  final double amount;
  final ScanStatus status;

  ScanState copyWith({ScanStatus? status, double? amount, Currency? currency}) {
    return ScanState(
      status: status ?? this.status,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return '''ScanState { status: $status, amount: $amount }''';
  }

  @override
  List<Object> get props => [status, amount];
}
