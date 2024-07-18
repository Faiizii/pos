import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/databse/model/sale_model.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/sale_dashboard/sale_controller.dart';

class SaleDashboardScreen extends GetView<SaleController> {
  const SaleDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SaleController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column(children: [
        const _SaleListTile(orderId: "Order ID", totalBill: "Total Bill", discountOffered: "Discount", paymentMethod: "Payment Method", orderDate: "Order Date", isHeadling: true,shopId: "Shop ID",),
        Expanded(child: ObxValue((RxList<Sale> rx){
          return ListView.separated(
            itemCount: rx.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              Sale model = rx[index];
              return _SaleListTile(orderId: "RMS000${model.id}", totalBill: model.saleAmount.toCurrency, discountOffered: model.discount.toCurrency, paymentMethod: model.paymentMethod.toUpperCase(), orderDate: '${model.createdAt}', shopId: model.shopId);
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
  final bool isHeadling;
  const _SaleListTile({super.key, required this.orderId, required this.totalBill, required this.discountOffered, required this.paymentMethod, required this.shopId, required this.orderDate, this.isHeadling = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Expanded(flex:1, child: Text(shopId, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
        Expanded(flex:1, child: Text(orderId, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(totalBill, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(discountOffered, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(paymentMethod, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
        Expanded(flex:2, child: Text(orderDate, style: isHeadling ? Get.textTheme.titleMedium : Get.textTheme.bodyMedium,)),
      ],),
    );
  }
}

