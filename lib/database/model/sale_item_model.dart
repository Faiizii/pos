class SaleItemModel {
  final int id;
  final int saleId;
  final int itemId;
  final String itemName;
  final double itemPrice;
  final String itemUnit;
  final int categoryId;
  final double quantity;

  SaleItemModel({
    required this.id,
    required this.saleId,
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.itemUnit,
    required this.categoryId,
    required this.quantity
  });

  // Convert a SaleItem object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saleID': saleId,
      'itemID': itemId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemUnit': itemUnit,
      'quantity': quantity,
      'categoryID': categoryId,
    };
  }

  // Convert a Map object into a SaleItem object
  factory SaleItemModel.fromMap(Map<String, dynamic> map) {
    return SaleItemModel(
      id: map['id'] ?? 0,
      saleId: map['saleID'] ?? 0,
      itemId: map['itemID'] ?? 0,
      itemName: map['itemName'] ?? "Item Deleted",
      itemPrice: double.tryParse('${map['itemPrice']}') ?? 0.0,
      itemUnit: map['itemUnit'] ?? 'NF',
      quantity: double.tryParse('${map['quantity']}') ?? 0.0,
      categoryId: map['categoryID'] ?? 0,
    );
  }
}