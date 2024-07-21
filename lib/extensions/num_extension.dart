extension Currency on num {
  String get toCurrency => 'SAR${toStringAsFixed(2)}';
  String get format => toStringAsFixed(2);
  String get formatRound => round().toString();
  String get shopID => "SHP${"$this".padLeft(4,"0")}";
  String get itemID => "ITM${"$this".padLeft(4,"0")}";
  String get orderID => "RMS${"$this".padLeft(4,"0")}";
}