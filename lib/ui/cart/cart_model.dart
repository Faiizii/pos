import 'package:pos/databse/model/item_model.dart';

class CartModel {

  final String name, unit;
  final int quantity;
  final double rate;

  CartModel({required this.name, required this.unit, required this.quantity, required this.rate});

  factory CartModel.fromItem(Item model, int qnt) => CartModel(name: model.name, unit: model.unit, quantity: qnt, rate: model.pricePerUnit);
}