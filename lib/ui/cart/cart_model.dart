import 'package:pos/databse/model/item_model.dart';

class CartModel {

  final Item item;
  final int quantity;

  CartModel({required this.item, required this.quantity, });

  factory CartModel.fromItem(Item model, int qnt) => CartModel(item: model, quantity: qnt);
}