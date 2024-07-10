import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';

class ItemsWidget extends GetView<CartBoardController> {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const _ItemListTile(itemId: "Item ID", itemName: "Item Name", itemUnit: "Item Unit", itemPrice: "Item Price", isHeadline: true,),
          const SizedBox(height: 16,),
          Expanded(
            child: ObxValue((rx){
              return ListView.builder(
                itemCount: rx.length,
                itemBuilder: (context, index) {
                  var model = rx[index];
                  return InkWell(
                    onTap: () {
                      controller.addItemToCart(model);
                    },
                      child: _ItemListTile(itemId: 'ITM000${model.id}', itemName: model.name, itemUnit: model.unit, itemPrice: model.pricePerUnit.toCurrency)
                  );
                },
              );
            }, controller.items),
          ),
        ],
      ),
    );
  }
}


class _ItemListTile extends StatelessWidget {
  final String itemId, itemName, itemUnit, itemPrice;
  final bool isHeadline;
  const _ItemListTile({super.key, required this.itemId, required this.itemName, required this.itemUnit, required this.itemPrice, this.isHeadline = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: [
        Expanded(child: Text(itemId, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(flex: 2, child: Text(itemName, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(child: Text(itemUnit, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(child: Text(itemPrice, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
      ],),
    );
  }
}