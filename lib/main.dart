import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exchange_repository/exchange_repository.dart';
import 'package:lekchange/app.dart';

void main() {
  final httpClient = http.Client();
  final exchangeRepository = ExchangeRepository(httpClient: httpClient);

  runApp(App(
    exchangeRepository: exchangeRepository,
  ));
}
