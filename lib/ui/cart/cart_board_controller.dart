import 'package:get/get.dart';
import 'package:pos/databse/model/category_model.dart';
import 'package:pos/databse/model/item_model.dart';
import 'package:pos/print/print_receipt.dart';
import 'package:pos/ui/cart/cart_model.dart';
import 'package:pos/ui/inventory/item_repo.dart';

enum PaymentType {
  cash, card
}
class CartBoardController extends GetxController {

  RxList<Item> items = RxList<Item>([]);
  RxList<CategoryModel> categories = RxList([]);

  RxList<CartModel> cartItems = RxList<CartModel>([]);

  Rx<PaymentType> paymentType = Rx(PaymentType.cash);

  RxDouble totalBill = 0.0.obs;

  @override
  void onInit() {
    _loadItems();
    super.onInit();
  }
  void refreshScreen() async {
    _loadItems();
  }

  void _loadItems() async {
    categories.value = await ItemRepo().getCategories();
    int categoryId = categories.firstOrNull?.id ?? 0;
    items.value = await ItemRepo().getItems(categoryId);
  }
  void loadItems(int categoryId) async {
    print("cat id :$categoryId");
    items.value = await ItemRepo().getItems(categoryId);
  }

  void addItemToCart(Item model){
    cartItems.add(CartModel.fromItem(model, 1));
    totalBill.value = totalBill.value + model.pricePerUnit;
  }

  void saveAndPrint(){
    RecieptManager().printReceipt(cartItems,"RMS00032", totalBill.value, paymentType.value);
  }

  void deleteCategory(int id) async {
    final repo = ItemRepo();
    await repo.deleteCategory(id);
    await repo.deleteItems(id);
    refresh();
  }
}