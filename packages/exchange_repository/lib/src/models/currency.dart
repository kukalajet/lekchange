class Currency {
  final String name;
  final String code;
  final String symbol;
  final double rate;

  const Currency({
    required this.name,
    required this.code,
    required this.symbol,
    required this.rate,
  });

  @override
  String toString() =>
      """{ name: $name, code: $code, symbol: $symbol, rate: $rate }""";

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'] as String,
      code: json['code'] as String,
      symbol: json['symbol'] as String,
      rate: json['rate'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static const empty = Currency(
    name: '',
    code: '',
    symbol: '',
    rate: double.nan,
  );
}
