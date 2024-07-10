
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';
import 'package:pos/ui/cart/cart_model.dart';

class CartWidget extends GetView<CartBoardController> {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
          const _ItemListTile(index: "Items",itemName: "Item Name", quantity: "Quantity", unitPrice: "Rate", totalPrice: "Amount", isHeadline: true,),
          const SizedBox(height: 16,),
          Expanded(child: ObxValue((rx){
            return ListView.builder(
              itemCount: rx.length,
              itemBuilder: (context, index) {
                CartModel model = rx[index];
                return _ItemListTile(index: "${index+1}", itemName: model.name, quantity: '${model.quantity}',unitPrice: model.rate.toCurrency ,totalPrice: (model.quantity * model.rate).toCurrency,);
              },
            );
          }, controller.cartItems)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total", style: Get.textTheme.headlineLarge,),
            ObxValue((rx){
              return Text(rx.value.toCurrency, style: Get.textTheme.headlineLarge,);
            }, controller.totalBill)
          ],),
          Row(mainAxisSize: MainAxisSize.min, children: [
            const Text("Discount (SAR)"),
            // TextField(),
            const Text("Payment Method"),
            ...PaymentType.values.map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
              child: ObxValue((rx){
                return ChoiceChip(label: Text(e.name.toUpperCase()), selected: rx.value == e, onSelected: (value) {
                  if(value){
                    controller.paymentType.value = e;
                  }
                },);
              }, controller.paymentType),
            )).toList()
          ],),
          SizedBox(width:double.infinity, height: 48, child: ElevatedButton(onPressed: (){
            controller.saveAndPrint();
          }, child: const Text("Save & Print"),))
        ],),
      ),
    );
  }
}


class _ItemListTile extends StatelessWidget {
  final String  itemName, quantity, unitPrice, totalPrice, index;
  final bool isHeadline;
  const _ItemListTile({super.key, required this.index, required this.itemName, required this.quantity, required this.unitPrice, required this.totalPrice, this.isHeadline = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: [
        Expanded(child: Text(index, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.labelSmall)),
        Expanded(flex: 2, child: Text(itemName, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(child: Text(quantity, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(child: Text(unitPrice, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(child: Text(totalPrice, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
      ],),
    );
  }
}