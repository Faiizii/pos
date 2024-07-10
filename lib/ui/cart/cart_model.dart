import 'package:pos/databse/model/item_model.dart';

class CartModel {

  final String name;
  final int quantity;
  final double rate;

  CartModel({required this.name, required this.quantity, required this.rate});

  factory CartModel.fromItem(Item model, int qnt) => CartModel(name: model.name, quantity: qnt, rate: model.pricePerUnit);
}