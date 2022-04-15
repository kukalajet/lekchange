import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/models.dart';

class ExchangeRepository {
  final http.Client httpClient;

  final _currenciesKey = 'currencies';

  const ExchangeRepository({required this.httpClient});

  Future<List<Currency>> fetchCurrencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final currenciesFromPrefs =
        await _fetchCurrenciesFromPrefs(sharedPreferences);
    if (currenciesFromPrefs != null) {
      return currenciesFromPrefs;
    }

    final currenciesFromServices = await _fetchCurrenciesFromServices();
    if (currenciesFromServices != null) {
      _storeCurrenciesInPrefs(sharedPreferences, currenciesFromServices);
      return currenciesFromServices;
    }

    return [Currency.empty];
  }

  Future<String?> getRedirectUrl(String url) async {
    try {
      final request = http.Request('GET', Uri.parse(url))
        ..followRedirects = false;
      final response = await httpClient.send(request);
      final redirect = response.headers['location'];

      return redirect;
    } on Exception {
      return null;
    }
  }

  Future<List<Currency>?> _fetchCurrenciesFromPrefs(
    SharedPreferences sharedPreferences,
  ) async {
    try {
      final response = sharedPreferences.getString(_currenciesKey);
      if (response == null) return null;
      final decoded = jsonDecode(response);
      final currencies = List<Currency>.from(
        decoded.map((item) => Currency.fromJson(item)),
      );

      return currencies;
    } on Exception {
      return null;
    }
  }

  Future<List<Currency>?> _fetchCurrenciesFromServices() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final decoded = jsonDecode(mock);
      final currencies = List<Currency>.from(
        decoded.map((item) => Currency.fromJson(item)),
      );

      return currencies;
    } on Exception {
      return null;
    }
  }

  Future<bool> _storeCurrenciesInPrefs(
    SharedPreferences sharedPreferences,
    List<Currency> currencies,
  ) async {
    final encoded = jsonEncode(currencies);
    return sharedPreferences.setString(_currenciesKey, encoded);
  }
}

const mock = '''
[
  {
    "name": "Euro",
    "code": "EUR",
    "symbol": "€",
    "rate": 0.0081
  },
  {
    "name": "U.S. Dollar",
    "code": "USD",
    "symbol": "\$",
    "rate": 0.0091
  },
  {
    "name": "Pound Sterling",
    "code": "GBP",
    "symbol": "£",
    "rate": 0.0069
  },
  {
    "name": "Russian Ruble",
    "code": "RUB",
    "symbol": "₽",
    "rate": 0.072
  }
]
''';
