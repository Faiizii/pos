extension Currency on num {
  String get toCurrency => 'SAR${toStringAsFixed(2)}';
  String get format => toStringAsFixed(2);
  String get formatRound => round().toString();
}