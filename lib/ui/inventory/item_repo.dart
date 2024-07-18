
import 'package:pos/databse/data_storage.dart';
import 'package:pos/databse/table/category_table.dart';
import 'package:pos/databse/table/item_table.dart';
import 'package:sqflite/sqflite.dart';

import '../../databse/model/category_model.dart';
import '../../databse/model/item_model.dart';

class ItemRepo {
  final DataStorage _db = DataStorage();

  Future<void> insertCategoryAndItem({required String itemName, required String unit, required double pricePerUnit, required CategoryModel category}) async {
    final db = await _db.getDatabase();
    int catId = category.id;
    var itemMap = {
      'name': itemName,
      'unit': unit,
      'price_per_unit': pricePerUnit
    };

    if(catId == 0){
      await db.transaction((txn) async {
        catId = await txn.insert(CategoryTable.tableName, category.toMap());
        itemMap['categoryID'] = catId;
        await txn.insert(ItemTable.tableName, itemMap);
      });
    }else {
      itemMap['categoryID'] = catId;
      await db.insert(ItemTable.tableName, itemMap);
    }
    await db.close();
  }

  // Insert an item into the getDatabase()
  Future<int> insertItem(Item item) async {
    final db = await _db.getDatabase();
    int id =  await db.insert(ItemTable.tableName, item.toMap());
    await db.close();
    return id;
  }

  // Retrieve all items from the getDatabase()
  Future<List<Item>> getAllItems() async {
    final db = await _db.getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
      ItemTable.tableName
    );
    var list = List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });

    await db.close();
    return list;
  }

  Future<List<Item>> getItems(int categoryId) async {
    final db = await _db.getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
        ItemTable.tableName,
      where: 'categoryID = ?',
      whereArgs: [categoryId],
    );
    var list = List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });

    await db.close();
    return list;
  }

  // Update an item in the getDatabase()
  Future<int> updateItem(Item item) async {
    final db = await _db.getDatabase();
    var id = await db.update(
      ItemTable.tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    await db.close();
    return id;
  }

  // Delete an item from the getDatabase()
  Future<int> deleteItem(int id) async {
    final db = await _db.getDatabase();
    var result =  await db.delete(
      ItemTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
    return result;
  }

  Future<int> deleteItems(int catId) async {
    final db = await _db.getDatabase();
    var result =  await db.delete(
      ItemTable.tableName,
      where: 'categoryID = ?',
      whereArgs: [catId],
    );
    await db.close();
    return result;
  }

  // Retrieve all categories from the getDatabase()
  Future<List<CategoryModel>> getCategories() async {
    final db = await _db.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CategoryTable.tableName);
    var list =  List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
    await db.close();
    return list;
  }

  // Delete a category from the getDatabase()
  Future<int> deleteCategory(int id) async {
    final db = await _db.getDatabase();
    var result =  await db.delete(
      CategoryTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
    return result;
  }
}