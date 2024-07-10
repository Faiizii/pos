
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
            SizedBox(width: double.infinity, height: 48,child: ElevatedButton(onPressed: (){
              Get.to(()=> const ItemListingScreen());
            }, child: const Text("Add New Item"),),),
            Expanded(
              child: ObxValue((rx){
                return ListView.builder(
                  itemCount: rx.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(rx[index].name), onTap: () {
                      controller.loadItems(rx[index].id);
                    }, trailing: IconButton(onPressed: (){
                      controller.deleteCategory(rx[index].id);
                    }, icon: Icon(Icons.delete),),);
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