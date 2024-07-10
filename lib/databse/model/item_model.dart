class Item {
  final int id;
  final String name;
  final String unit;
  final double pricePerUnit;
  final int categoryId;
  final String? createdAt;
  final String? updatedAt;

  Item({
    required this.id,
    required this.name,
    required this.unit,
    required this.pricePerUnit,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  // Convert an Item object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'unit': unit,
      'price_per_unit': pricePerUnit,
      'categoryID': categoryId,
    };
  }

  // Convert a Map object into an Item object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? 0,
      name: map['name'],
      unit: map['unit'],
      pricePerUnit: map['price_per_unit'],
      categoryId: map['categoryID'] ?? 0,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}