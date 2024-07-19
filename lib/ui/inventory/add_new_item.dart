import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/database/model/category_model.dart';
import 'package:pos/ui/inventory/inventory_controller.dart';

class AddItemDialog extends GetView<InventoryController> {
  const AddItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item Details",), centerTitle: false, actions: [
        TextButton(onPressed: (){
          controller.saveItem();
        }, child: const Text("Save Item"))
      ],),
      body: SafeArea(child: Row(children: [
        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
          _InputGroup(label: "Item Name", controller: controller.cName),
          _InputGroup(label: "Item Price/Unit", controller: controller.cPrice),
          _InputGroup(label: "Item Unit", controller: controller.cUnit),
        ],)),
        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
          const _InputGroup(label: "Item Group", onlyLabel: true,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
            child: ObxValue((rx) {
              print(rx);
              return Autocomplete<CategoryModel>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  // Filter categories based on user input
                  var list = rx.where((CategoryModel category) =>
                      category.name.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      ));
                  if(list.isEmpty){
                    controller.noCatSelect(textEditingValue.text.toUpperCase());
                  }
                  return list;
                },
                displayStringForOption: (CategoryModel category) => category.name,
                onSelected: (CategoryModel category) {
                  controller.selectedCategory = category;
                },
              );
            }, controller.categories),
          ),

        ],))
      ],),),
    );
  }
}

class _InputGroup extends StatelessWidget {
  final String label;
  final bool onlyLabel;
  final TextEditingController? controller;

  const _InputGroup({super.key, required this.label, this.controller, this.onlyLabel = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
        Text(label, style: Get.textTheme.labelMedium,),
        if(!onlyLabel)
          Padding(
          padding: const EdgeInsets.only(top:4.0, bottom: 32),
          child: TextField(controller: controller,),
        ),
      ],),
    );
  }
}

