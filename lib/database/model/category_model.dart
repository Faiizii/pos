class CategoryModel {
  final int id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  // Convert a Category object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Convert a Map object into a Category object
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? 0,
      name: map['name'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}