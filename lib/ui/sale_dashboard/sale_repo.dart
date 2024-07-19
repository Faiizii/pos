import 'package:pos/database/data_storage.dart';
import 'package:pos/database/model/sale_model.dart';
import 'package:pos/database/table/sale_table.dart';

class SaleRepo {
  Future<List<Sale>> getSaleReport() async {
    var db = await DataStorage().getDatabase();
    List<Map<String, dynamic>> map = await db.query(SaleTable.tableName);
    return map.map((ele)=> Sale.fromMap(ele)).toList();
  }

}