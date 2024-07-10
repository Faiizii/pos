import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/inventory/add_new_item.dart';
import 'package:pos/ui/inventory/inventory_controller.dart';

class ItemListingScreen extends GetView<InventoryController> {
  const ItemListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InventoryController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Get.dialog(const AddItemDialog());
          }, icon: const Text("Add New Item")),

          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: IconButton(onPressed: (){
              controller.refreshData();
            }, icon: const Icon(Icons.refresh)),
          )],
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const _ItemListTile(itemId: "Item ID", itemName: "Item Name", itemUnit: "Item Unit", itemPrice: "Item Price", isHeadline: true,),
            Expanded(
              child: ObxValue((rx){
                if(rx.isEmpty){
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("No item added. Please add new item", style: Get.textTheme.labelLarge?.copyWith(color: Colors.red),),
                    const SizedBox(height: 8,),
                    ElevatedButton(onPressed: (){
                      Get.dialog(const AddItemDialog());
                    }, child: const Text("Add New Item"))
                  ],);
                }
                return ListView.separated(
                  itemCount: rx.length,
                  itemBuilder: (context, index) {
                    var model = rx[index];
                    return _ItemListTile(itemId: '${index+1}', itemName: model.name, itemUnit: model.unit, itemPrice: model.pricePerUnit.toCurrency, callback: () {
                      controller.deleteItem(model.id);
                    },);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              },controller.items),
            ),
          ],
        ),
      ),),
    );
  }
}

class _ItemListTile extends StatelessWidget {
  final bool isHeadline;
  final String itemId, itemName, itemUnit, itemPrice;
  final VoidCallback? callback;
  const _ItemListTile({super.key, required this.itemId, required this.itemName, required this.itemUnit, required this.itemPrice, this.isHeadline = false, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Expanded(child: Text(itemId, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.labelSmall)),
        Expanded(flex: 2, child: Text(itemName, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.labelSmall)),
        Expanded(child: Text(itemUnit, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.labelSmall)),
        Expanded(child: Text(itemPrice, style: isHeadline ? Get.textTheme.titleMedium : Get.textTheme.labelSmall)),
        Visibility(visible: !isHeadline, maintainSize: true, maintainAnimation: true, maintainState: true, child: IconButton(onPressed: callback, icon: const Icon(Icons.delete)))

      ],),
    );
  }
}
