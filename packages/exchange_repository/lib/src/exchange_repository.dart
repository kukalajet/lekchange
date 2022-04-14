import 'package:http/http.dart' as http;
import 'models/models.dart';

class ExchangeRepository {
  final http.Client httpClient;

  const ExchangeRepository({required this.httpClient});

  Future<List<Currency>> fetchCurrencies() async {
    final currencies = const <Currency>[
      Currency(name: 'Euro', code: "EUR", symbol: "€", rate: 0.0081),
      Currency(name: 'U.S. Dollar', code: "USD", symbol: "\$", rate: 0.0091),
      Currency(name: 'Pound Sterling', code: "GBP", symbol: "£", rate: 0.0069),
      Currency(name: 'Russian Ruble', code: "RUB", symbol: "₽", rate: 0.72),
    ];

    await Future.delayed(Duration(seconds: 3));

    return currencies;
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
}
