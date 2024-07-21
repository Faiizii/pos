import 'package:pos/database/model/sale_item_model.dart';

class SaleModel {
  final int id;
  final String paymentMethod;
  final String? createdAt;
  final double discount;
  final double saleAmount;
  final String? customerName;
  final String? customerPhoneNumber;
  final int shopId;
  final List<SaleItemModel> items;

  SaleModel({
    required this.id,
    required this.paymentMethod,
    this.createdAt,
    required this.discount,
    required this.saleAmount,
    this.customerName,
    this.customerPhoneNumber,
    this.shopId = 1,
    required this.items
  });

  // Convert a Sale object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'discount': discount,
      'saleAmount': saleAmount,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'shopID': shopId,
    };
  }

  // Convert a Map object into a Sale object
  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'] ?? 0,
      paymentMethod: map['paymentMethod'],
      createdAt: map['created_at'],
      discount: double.tryParse('${map['discount'] ?? 0.0}') ?? 0.0,
      saleAmount: double.tryParse('${map['saleAmount'] ?? 0.0}') ?? 0.0,
      customerName: map['customerName'],
      customerPhoneNumber: map['customerPhoneNumber'],
      shopId: int.tryParse('${map['shopID']}') ?? 0,
      items: []
    );
  }

  void updateItems(List<SaleItemModel> items){
    this.items.clear();
    this.items.addAll(items);
  }

}
