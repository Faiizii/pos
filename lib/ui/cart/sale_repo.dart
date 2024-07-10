

import 'package:pos/databse/data_storage.dart';
import 'package:pos/databse/table/sale_table.dart';

import '../../databse/model/sale_model.dart';

class SaleRepository {
  final DataStorage _dbHelper = DataStorage();

  // Insert a sale into the getDatabase()
  Future<int> insertSale(Sale sale) async {
    final db = await _dbHelper.getDatabase();
    var id =  await db.insert(SaleTable.tableName, sale.toMap());
    await db.close();
    return id;
  }

  // Retrieve all sales from the getDatabase()
  Future<List<Sale>> getSales() async {
    final db = await _dbHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(SaleTable.tableName);
    var list = List.generate(maps.length, (i) {
      return Sale.fromMap(maps[i]);
    });

    await db.close();
    return list;
  }

  // Update a sale in the getDatabase()
  Future<int> updateSale(Sale sale) async {
    final db = await _dbHelper.getDatabase();
    var id = await db.update(
      SaleTable.tableName,
      sale.toMap(),
      where: 'id = ?',
      whereArgs: [sale.id],
    );

    await db.close();
    return id;
  }

  // Delete a sale from the getDatabase()
  Future<int> deleteSale(int id) async {
    final db = await _dbHelper.getDatabase();
    var result = await db.delete(
      SaleTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();
    return result;
  }
}
