import 'package:get/get.dart';
import 'package:pos/databse/model/category_model.dart';
import 'package:pos/databse/model/item_model.dart';
import 'package:pos/databse/model/sale_model.dart';
import 'package:pos/print/print_receipt.dart';
import 'package:pos/ui/cart/cart_model.dart';
import 'package:pos/ui/cart/sale_repo.dart';
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
  double discount = 0.0;

  @override
  void onInit() {
    _loadItems();
    super.onInit();
  }
  void refreshScreen() async {
    _loadItems();
    cartItems.clear();
    totalBill.value = 0;
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

  void addItemToCart(Item model, int qty){
    cartItems.add(CartModel.fromItem(model, qty));
    totalBill.value = totalBill.value + (model.pricePerUnit * qty);
  }

  void saveAndPrint() async {
    int id = await SaleRepository().insertSale(paymentMethod: paymentType.value.name, discount: discount, saleAmount: totalBill.value, items: cartItems);
    RecieptManager().printReceipt(cartItems,"RMS000$id", totalBill.value, discount, paymentType.value);
  }

  void deleteCategory(int id) async {
    final repo = ItemRepo();
    await repo.deleteCategory(id);
    await repo.deleteItems(id);
    _loadItems();
  }
}