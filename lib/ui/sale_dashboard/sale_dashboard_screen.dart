import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/database/model/sale_model.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/sale_dashboard/sale_controller.dart';

import '../../database/model/sale_item_model.dart';

class SaleDashboardScreen extends GetView<SaleController> {
  const SaleDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SaleController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column(children: [
        const _SaleListTile(orderId: "Order ID", totalBill: "Total Bill", discountOffered: "Discount", paymentMethod: "Payment Method", orderDate: "Order Date", isHeadline: true,shopId: "Shop ID", items: [],),
        Expanded(child: ObxValue((RxList<SaleModel> rx){
          return ListView.builder(
            itemCount: rx.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              SaleModel model = rx[index];
              return _SaleListTile(orderId: model.id.orderID, totalBill: model.saleAmount.toCurrency, discountOffered: model.discount.toCurrency, paymentMethod: model.paymentMethod.toUpperCase(), orderDate: '${model.createdAt}', shopId: model.shopId.shopID, items: model.items,);
            },
          );
        }, controller.sale),),
      ],)),
    );
  }
}

class _SaleListTile extends StatelessWidget {
  final String orderId;
  final String totalBill;
  final String discountOffered;
  final String paymentMethod;
  final String orderDate;
  final String shopId;
  final List<SaleItemModel> items;
  final bool isHeadline;
  const _SaleListTile({super.key, required this.orderId, required this.totalBill, required this.discountOffered, required this.paymentMethod, required this.shopId, required this.orderDate, required this.items, this.isHeadline = false});

  @override
  Widget build(BuildContext context) {
    if(isHeadline) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(flex:1, child: Text(shopId, style:  Get.textTheme.titleMedium )),
          Expanded(flex:1, child: Text(orderId, style:  Get.textTheme.titleMedium )),
          Expanded(flex:2, child: Text(totalBill, style:  Get.textTheme.titleMedium )),
          Expanded(flex:2, child: Text(discountOffered, style:  Get.textTheme.titleMedium )),
          Expanded(flex:2, child: Text(paymentMethod, style:  Get.textTheme.titleMedium )),
          Expanded(flex:2, child: Text(orderDate, style:  Get.textTheme.titleMedium )),
        ],),
      );
    }
    return ExpansionTile(
      title: Row(children: [
        Expanded(flex:1, child: Text(shopId, style: Get.textTheme.bodyMedium,)),
        Expanded(flex:1, child: Text(orderId, style: Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(totalBill, style: Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(discountOffered, style: Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(paymentMethod, style: Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(orderDate, style: Get.textTheme.bodyMedium,)),
      ],),
      children: items.map((iModel){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: Text('Item ID: ${iModel.itemId.itemID}', style: Get.textTheme.bodyMedium,)),
            Expanded(child: Text('Item Name: ${iModel.itemName}', style: Get.textTheme.bodyMedium,)),
            Expanded(child: Text('Unit Price: ${iModel.itemPrice.format}/${iModel.itemUnit}', style: Get.textTheme.bodyMedium,)),
            Expanded(child: Text('Quantity Sold: ${iModel.quantity}${iModel.itemUnit}', style: Get.textTheme.bodyMedium,)),
            Expanded(child: Text('Sale Price: ${(iModel.quantity * iModel.itemPrice).format}', style: Get.textTheme.bodyMedium,)),
          ],),
        );
      }).toList()
    );

  }
}

