
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/databse/model/category_model.dart';
import 'package:pos/databse/model/item_model.dart';
import 'package:pos/ui/inventory/item_repo.dart';

class InventoryController extends GetxController {
  RxList<Item> items = RxList<Item>([]);
  RxList<CategoryModel> categories = RxList([]);

  final TextEditingController cName = TextEditingController(), cUnit = TextEditingController(), cPrice = TextEditingController();

  CategoryModel? selectedCategory;
  @override
  void onInit() {
    _loadItems();
    super.onInit();
  }

  void refreshData() {
    _loadItems();
  }
  void _loadItems() async {
    categories.value = await ItemRepo().getCategories();
    items.value = await ItemRepo().getAllItems();
  }

  void updateItems(int categoryId) async {
    items.value = await ItemRepo().getItems(categoryId);
  }

  void noCatSelect(String category){
    selectedCategory = CategoryModel(id: 0, name: category);
  }

  void saveItem() async {
    await ItemRepo().insertCategoryAndItem(itemName: cName.text, category: selectedCategory ?? CategoryModel(id: 99999, name: "No Category"), unit: cUnit.text, pricePerUnit: double.tryParse(cPrice.text) ?? 0.0);
    Get.back();
    Get.showSnackbar(const GetSnackBar(message: "Item added successfully!",));

  }

  void deleteItem(int id) async {
    await ItemRepo().deleteItem(id);
    Get.showSnackbar(const GetSnackBar(message: "Item deleted Successfully"));
  }
}