import 'package:pos/databse/table/category_table.dart';
import 'package:pos/databse/table/item_table.dart';
import 'package:pos/databse/table/sale_table.dart';

class SaleItemTable {
  static const String tableName = "sale_item";
  static const createStatement = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "itemID INTEGER NOT NULL,"
      "itemPrice DECIMAL(10, 2) NOT NULL,"
      "itemUnit VARCHAR(10) NOT NULL,"
      "categoryID INTEGER NOT NULL,"
      "saleID INTEGER NOT NULL,"
      "FOREIGN KEY (itemID) REFERENCES ${ItemTable.tableName}(id),"
      "FOREIGN KEY (categoryID) REFERENCES ${CategoryTable.tableName}(id),"
      "FOREIGN KEY (saleID) REFERENCES ${SaleTable.tableName}(id)"
  ");";
}