import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';
import 'package:pos/ui/inventory/item_list_screen.dart';

class ItemCategoryWidget extends GetView<CartBoardController> {
  const ItemCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const ItemListingScreen());
                },
                child: Text("Add Item", style: Get.textTheme.labelSmall,),
              ),
            ),
            Expanded(
              child: ObxValue((rx) {
                return ListView.builder(
                  itemCount: rx.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(rx[index].name, style: Get.textTheme.labelSmall,),
                      onTap: () {
                        controller.loadItems(rx[index].id);
                      },
                      contentPadding: const EdgeInsets.only(left:6),
                      dense: true,
                      trailing: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          controller.deleteCategory(rx[index].id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                );
              }, controller.categories),
            ),
          ],
        ),
      ),
    );
  }
}
