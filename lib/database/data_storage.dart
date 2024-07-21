import 'package:pos/database/table/category_table.dart';
import 'package:pos/database/table/item_table.dart';
import 'package:pos/database/table/sale_item_table.dart';
import 'package:pos/database/table/sale_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

base class DataStorage {
  Future<Database> getDatabase() async {
    var path = p.join(await getDatabasesPath(), "rms_database.db");

    return await openDatabase(
      path,
      version: 4,
      onCreate: (db,version){
        db.execute(ItemTable.createStatement);
        db.execute(CategoryTable.createStatement);
        db.execute(SaleTable.createStatement);
        db.execute(SaleItemTable.createStatement);
      },
      onUpgrade: (db, oldVersion, newVersion) {

        db.execute("DROP TABLE IF EXISTS ${ItemTable.tableName}");
        db.execute("DROP TABLE IF EXISTS ${CategoryTable.tableName}");
        db.execute("DROP TABLE IF EXISTS ${SaleTable.tableName}");
        db.execute("DROP TABLE IF EXISTS ${SaleItemTable.tableName}");

        db.execute(ItemTable.createStatement);
        db.execute(CategoryTable.createStatement);
        db.execute(SaleTable.createStatement);
        db.execute(SaleItemTable.createStatement);
      },
    );
  }
}