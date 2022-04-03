import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_repository/exchange_repository.dart';
import 'package:lekchange/blocs/blocs.dart';
import 'package:lekchange/app.dart';

void main() {
  final httpClient = http.Client();
  final exchangeRepository = ExchangeRepository(httpClient: httpClient);

  BlocOverrides.runZoned(
    () => runApp(App(
      exchangeRepository: exchangeRepository,
    )),
    blocObserver: SimpleBlocObserver(),
  );
}
