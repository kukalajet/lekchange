part of 'scan_bloc.dart';

enum ScanStatus { initial, valid, notValid }

class ScanState extends Equatable {
  const ScanState({
    this.status = ScanStatus.initial,
    this.value = '',
    this.currency = Currency.empty,
  });

  final String value;
  final ScanStatus status;
  final Currency currency;

  ScanState copyWith({ScanStatus? status, String? value, Currency? currency}) {
    return ScanState(
      status: status ?? this.status,
      value: value ?? this.value,
      currency: currency ?? this.currency,
    );
  }

  @override
  String toString() {
    return '''ScanState { status: $status, value: $value }''';
  }

  @override
  List<Object> get props => [status, value];
}
