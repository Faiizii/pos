class SaleItem {
  final int id;
  final int saleId;
  final int itemId;
  final double itemPrice;
  final String itemUnit;
  final int categoryId;

  SaleItem({
    required this.id,
    required this.saleId,
    required this.itemId,
    required this.itemPrice,
    required this.itemUnit,
    required this.categoryId,
  });

  // Convert a SaleItem object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sale_id': saleId,
      'item_id': itemId,
      'item_price': itemPrice,
      'item_unit': itemUnit,
      'category_id': categoryId,
    };
  }

  // Convert a Map object into a SaleItem object
  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'] ?? 0,
      saleId: map['sale_id'] ?? 0,
      itemId: map['item_id'] ?? 0,
      itemPrice: map['item_price'] ?? 0.0,
      itemUnit: map['item_unit'],
      categoryId: map['category_id'] ?? 0,
    );
  }
}
