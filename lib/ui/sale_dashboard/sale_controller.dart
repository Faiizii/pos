import 'package:get/get.dart';
import 'package:pos/ui/sale_dashboard/sale_repo.dart';

import '../../database/model/sale_model.dart';

class SaleController extends GetxController {
  RxList<SaleModel> sale = RxList([]);
  @override
  void onInit() {
    _loadData();
    super.onInit();
  }
  void _loadData() async {
    sale.addAll(await SaleRepo().getSaleReport());
    sale.refresh();
  }
}