

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pos/databse/data_storage.dart';
import 'package:pos/databse/model/item_model.dart';
import 'package:pos/databse/table/sale_item_table.dart';
import 'package:pos/databse/table/sale_table.dart';
import 'package:pos/ui/cart/cart_model.dart';

import '../../databse/model/sale_model.dart';

class SaleRepository {
  final DataStorage _dbHelper = DataStorage();

  // Insert a sale into the getDatabase()
  Future<int> insertSale({required String paymentMethod, required discount, required double saleAmount, required List<CartModel> items}) async {
    final db = await _dbHelper.getDatabase();
    var batch = db.batch();

    batch.insert(SaleTable.tableName, {
      'paymentMethod': paymentMethod,
      'discount': discount,
      'saleAmount': saleAmount,
      'customerName': "-",
      'customerPhoneNumber': "-",
      'shopID': "SHP00001", // main shopID
    });

    int id = int.tryParse('${(await batch.commit()).firstOrNull ?? 0}') ?? 0;

    for(CartModel model in items){

      batch.insert(SaleItemTable.tableName, {
        "itemID": model.item.id,
        "itemPrice": model.item.pricePerUnit,
        "itemUnit": model.item.unit,
        "quantity": model.quantity,
        "categoryID": model.item.categoryId,
        "saleID": id
      });
    }

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
