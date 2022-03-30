part of 'scan_bloc.dart';

enum ScanStatus { initial, searching, success, failure }

class ScanState extends Equatable {
  const ScanState({this.status = ScanStatus.initial, this.value = ''});

  final ScanStatus status;
  final String value;

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
