import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';
import 'package:pos/ui/sale_dashboard/sale_dashboard_screen.dart';

import 'cart_widgets/cart_widget.dart';
import 'cart_widgets/category_widget.dart';
import 'cart_widgets/item_widget.dart';

class CartBoardScreen extends StatelessWidget {
  const CartBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartBoardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Al Reem: Fresh Pakistani Meat Shop"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>const SaleDashboardScreen());
          }, icon: const Icon(Icons.dashboard)),
          IconButton(onPressed: (){
            controller.refreshScreen();
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: const SafeArea(child: Row(children: [
        Expanded(flex: 1, child: ItemCategoryWidget()),
        Expanded(flex:4,child: ItemsWidget()),
        Expanded(flex:3,child: CartWidget())
      ],)),
    );
  }
}


