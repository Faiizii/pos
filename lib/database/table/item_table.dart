import 'package:pos/database/table/category_table.dart';

class ItemTable {
  static const String tableName = "item";
  static const createStatement = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "name VARCHAR(255) NOT NULL,"
      "unit VARCHAR(10) NOT NULL,"
      "price_per_unit DECIMAL(10, 2) NOT NULL,"
      "categoryID INTEGER NOT NULL,"
      "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
      "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
      "FOREIGN KEY (categoryID) REFERENCES ${CategoryTable.tableName}(id)"
  ");";
}