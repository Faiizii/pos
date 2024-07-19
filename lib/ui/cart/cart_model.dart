import 'package:pos/database/model/item_model.dart';

class CartModel {

  final Item item;
  final double quantity;

  CartModel({required this.item, required this.quantity, });

  factory CartModel.fromItem(Item model, double qnt) => CartModel(item: model, quantity: qnt);
}