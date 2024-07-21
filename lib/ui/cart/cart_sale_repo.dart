
import 'package:pos/database/data_storage.dart';
import 'package:pos/database/table/sale_item_table.dart';
import 'package:pos/database/table/sale_table.dart';
import 'package:pos/ui/cart/cart_model.dart';

import '../../database/model/sale_model.dart';

class CartSaleRepo {
  final DataStorage _dbHelper = DataStorage();

  // Insert a sale into the getDatabase()
  Future<int> insertSale({required String paymentMethod, required discount, required double saleAmount, required List<CartModel> items}) async {
    final db = await _dbHelper.getDatabase();
    int orderId = 0;
    await db.transaction((trnx) async {
      orderId = await trnx.insert(SaleTable.tableName, {
        'paymentMethod': paymentMethod,
        'discount': discount,
        'saleAmount': saleAmount,
        'customerName': "-",
        'customerPhoneNumber': "-",
        'shopID': 1, // main shopID
      });

      for(CartModel model in items){

        await trnx.insert(SaleItemTable.tableName, {
          "itemID": model.item.id,
          "itemPrice": model.item.pricePerUnit,
          "itemUnit": model.item.unit,
          "quantity": model.quantity,
          "categoryID": model.item.categoryId,
          "saleID": orderId
        });
      }
    });

    await db.close();
    return orderId;
  }

  // Retrieve all sales from the getDatabase()
  Future<List<SaleModel>> getSales() async {
    final db = await _dbHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(SaleTable.tableName);
    var list = List.generate(maps.length, (i) {
      return SaleModel.fromMap(maps[i]);
    });

    await db.close();
    return list;
  }

  // Update a sale in the getDatabase()
  Future<int> updateSale(SaleModel sale) async {
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
