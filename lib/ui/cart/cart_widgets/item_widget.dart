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
          const _ItemListTile(itemId: "Item ID", itemName: "Name", itemUnit: "QTY", itemPrice: "Price (SAR)", isHeadline: true,),
          const SizedBox(height: 16,),
          Expanded(
            child: ObxValue((rx){
              return ListView.builder(
                itemCount: rx.length,
                itemBuilder: (context, index) {
                  var model = rx[index];
                  final qController = TextEditingController(text: "1000");
                  return InkWell(
                      child: _ItemListTile(
                        itemId: 'ITM000${model.id}', itemName: model.name,
                        itemUnit: model.unit,
                        itemPrice: model.pricePerUnit.format,
                        qController: qController,
                        addItem: () {
                        controller.addItemToCart(model, int.tryParse(qController.text) ?? 0);
                      },)
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
  final TextEditingController? qController;
  final VoidCallback? addItem;
  const _ItemListTile({super.key, required this.itemId, required this.itemName, required this.itemUnit, required this.itemPrice, this.qController, this.addItem, this.isHeadline = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: [
        Expanded(child: Text(itemId, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Expanded(flex: 2, child: Text(itemName, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),

        if(!isHeadline)
          Expanded(child: Row(children: [
            Expanded(child: SizedBox(width:50, height: 48, child: TextField(controller: qController, maxLines: 1,),)),
            Text(itemUnit, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall),
            const SizedBox(width: 32,),
          ],)),

        if(isHeadline)
          Expanded(child: Text(itemUnit, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),

        Expanded(child: Text(itemPrice, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.bodySmall)),
        Visibility(
          visible: addItem != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: IconButton(onPressed: addItem, icon: const Icon(Icons.add),),
        )
      ],),
    );
  }
}