part of 'scan_bloc.dart';

enum ScanStatus { initial, valid, notValid }

class ScanState extends Equatable {
  const ScanState({this.status = ScanStatus.initial, this.value = ''});

  final String value;
  final ScanStatus status;

  ScanState copyWith({ScanStatus? status, String? value}) {
    return ScanState(status: status ?? this.status, value: value ?? this.value);
  }

  @override
  String toString() {
    return '''ScanState { status: $status, value: $value }''';
  }

  @override
  List<Object> get props => [status, value];
}
