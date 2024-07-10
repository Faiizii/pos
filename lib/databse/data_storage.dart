import 'package:pos/databse/table/category_table.dart';
import 'package:pos/databse/table/item_table.dart';
import 'package:pos/databse/table/sale_item_table.dart';
import 'package:pos/databse/table/sale_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

base class DataStorage {
  Future<Database> getDatabase() async {
    var path = p.join(await getDatabasesPath(), "rms_database.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db,version){
        db.execute(ItemTable.createStatement);
        db.execute(CategoryTable.createStatement);
        db.execute(SaleTable.createStatement);
        db.execute(SaleItemTable.createStatement);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(ItemTable.createStatement);
        db.execute(CategoryTable.createStatement);
        db.execute(SaleTable.createStatement);
        db.execute(SaleItemTable.createStatement);
      },
    );
  }
}