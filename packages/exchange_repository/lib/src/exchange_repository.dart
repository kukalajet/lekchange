import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class ExchangeRepository {
  final http.Client httpClient;

  const ExchangeRepository({@required this.httpClient});

  Future<List<Currency>> fetchCurrencies() async {
    final currencies = <Currency>[
      Currency(name: 'Euro', code: "EUR", symbol: "€", rate: 0.0081),
      Currency(name: 'U.S. Dollar', code: "USD", symbol: "\$", rate: 0.0091),
      Currency(name: 'Pound Sterling', code: "GBP", symbol: "£", rate: 0.0069),
    ];

    return currencies;
  }
}
