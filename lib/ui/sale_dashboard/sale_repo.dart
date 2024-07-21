import 'package:pos/database/data_storage.dart';
import 'package:pos/database/model/sale_model.dart';
import 'package:pos/database/table/item_table.dart';
import 'package:pos/database/table/sale_item_table.dart';
import 'package:pos/database/table/sale_table.dart';

import '../../database/model/sale_item_model.dart';

class SaleRepo {

  Future<List<SaleModel>> getSaleReport() async {
    var db = await DataStorage().getDatabase();
    List<Map<String, dynamic>> dMap = await db.query(SaleTable.tableName);
    List<SaleModel> list = [];
    for(var map in dMap){
      var sModel = SaleModel.fromMap(map);
      // List<Map<String, dynamic>> iData = await db.query(SaleItemTable.tableName, where: 'saleID=?', whereArgs: [sModel.id]);
      List<Map<String, dynamic>> iData = await db.rawQuery(""
          "SELECT si.*, i.name as itemName "
          "FROM ${SaleItemTable.tableName} si "
          "LEFT JOIN ${ItemTable.tableName} i ON si.itemID = i.id "
          "WHERE saleID = '${sModel.id}'"
          "");

      sModel.updateItems(iData.map((iMap)=>SaleItemModel.fromMap(iMap)).toList());
      list.add(sModel);
    }
    await db.close();
    return list;
  }

}