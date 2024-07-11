extension Currency on num {
  String get toCurrency => 'SAR${toStringAsFixed(3)}';
  String get format => toStringAsFixed(3);
  String get formatRound => round().toString();
}