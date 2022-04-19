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
      "code":"EUR",
      "rate":0.0083,
      "name":"Euro",
      "symbol":"€"
   },
   {
      "code":"USD",
      "rate":0.0090,
      "name":"U.S. Dollar",
      "symbol":"\$"
   },
   {
      "code":"CHF",
      "rate":0.0085,
      "name":"Swiss Franc",
      "symbol":"CHf"
   },
   {
      "code":"GBP",
      "rate":0.0069,
      "name":"British Pound",
      "symbol":"£"
   },
   {
      "code":"DKK",
      "rate":0.0632,
      "name":"Danish Krone",
      "symbol":"Kr."
   },
   {
      "code":"NOK",
      "rate":0.0812,
      "name":"Norwegian Krone",
      "symbol":"kr"
   },
   {
      "code":"SEK",
      "rate":0.0883,
      "name":"Swedish Krona",
      "symbol":"kr"
   },
   {
      "code":"CAD",
      "rate":0.0114,
      "name":"Canadian Dollar",
      "symbol":"CA\$"
   },
   {
      "code":"AUD",
      "rate":0.0123,
      "name":"Australian Dollar",
      "symbol":"AU\$"
   },
   {
      "code":"JPY",
      "rate":1.3699,
      "name":"Japanese Yen",
      "symbol":"¥"
   },
   {
      "code":"TRY",
      "rate":0.1412,
      "name":"Turkish Lira",
      "symbol":"₺"
   },
   {
      "code":"MKD",
      "rate":0.5405,
      "name":"Macedonian Denar",
      "symbol":"Ден"
   },
   {
      "code":"BGN",
      "rate":0.0191,
      "name":"undefined",
      "symbol":"undefined"
   },
   {
      "code":"RON",
      "rate":0.0483,
      "name":"Romanian Leu",
      "symbol":"lei"
   },
   {
      "code":"HUF",
      "rate":3.7037,
      "name":"Hungarian Forint",
      "symbol":"Ft"
   },
   {
      "code":"RUB",
      "rate":0.8475,
      "name":"Russian Ruble",
      "symbol":"₽"
   },
   {
      "code":"PLN",
      "rate":0.0455,
      "name":"Polish Złoty",
      "symbol":"zł"
   },
   {
      "code":"HRK",
      "rate":0.0698,
      "name":"Croatian Kuna",
      "symbol":"kn"
   },
   {
      "code":"CZK",
      "rate":0.2375,
      "name":"Czech Koruna",
      "symbol":"Kč"
   },
   {
      "code":"ILS",
      "rate":0.0361,
      "name":"Israeli Shekel",
      "symbol":"₪"
   },
   {
      "code":"CNY",
      "rate":0.0706,
      "name":"Renminbi",
      "symbol":"CN¥"
   },
   {
      "code":"RSD",
      "rate":1.1494,
      "name":"Serbian Dinar",
      "symbol":"din"
   },
   {
      "code":"ISK",
      "rate":1.5625,
      "name":"Icelandic Króna",
      "symbol":"kr"
   },
   {
      "code":"MXN",
      "rate":0.2304,
      "name":"Mexican Peso",
      "symbol":"MX\$"
   },
   {
      "code":"AED",
      "rate":0.0383,
      "name":"United Arab Emirates Dirham",
      "symbol":"د.إ"
   },
   {
      "code":"SAR",
      "rate":0.0442,
      "name":"Saudi Riyal",
      "symbol":"ر.س"
   },
   {
      "code":"SGN",
      "rate":0.0160,
      "name":"Singapore Dollar",
      "symbol":"S\$"
   },
   {
      "code":"KWD",
      "rate":0.0036,
      "name":"Kuwaiti Dinar",
      "symbol":"د.ك"
   },
   {
      "code":"QAR",
      "rate":0.0429,
      "name":"Qatari Riyal",
      "symbol":"ر.ق"
   },
   {
      "code":"BHD",
      "rate":0.0044,
      "name":"Bahraini Dinar",
      "symbol":"د.ب"
   }
]
''';
