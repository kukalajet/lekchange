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

  static const empty = Currency(
    name: '',
    code: '',
    symbol: '',
    rate: double.nan,
  );
}
