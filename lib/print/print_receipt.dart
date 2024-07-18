import 'package:get/get.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';
import 'package:pos/ui/cart/cart_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class RecieptManager {
  void printReceipt(List<CartModel> list, String invoiceNo, double total, double discount,
      PaymentType paymentType) async {
    final doc = Document();

    double baseSize = 9; //heading will be multiply with 1.5

    var image = await imageFromAssetBundle("images/logo.jpeg");
    doc.addPage(Page(
        pageFormat: PdfPageFormat.roll80,
        build: (Context context) {
          return Column(children: [
            Image(image, width: baseSize * 16, height: baseSize * 16),
            Text("Al Reem Meat Shop",
                style: TextStyle(fontSize: baseSize * 1.2)),
            Text("Al Murqeen Street 22, Madinatul Umal",
                style: TextStyle(fontSize: baseSize * 1.2)),
            Text("Al Khobar", style: TextStyle(fontSize: baseSize * 1.5)),
            Divider(),
            Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Invoice# ",
                        style: TextStyle(
                            fontSize: baseSize, fontWeight: FontWeight.bold)),
                    Text("Date ",
                        style: TextStyle(
                            fontSize: baseSize, fontWeight: FontWeight.bold)),
                  ])),
              Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(invoiceNo, style: TextStyle(fontSize: baseSize)),
                        Text(DateTime.now().toString(),
                            style: TextStyle(fontSize: baseSize))
                      ]))
            ]),
            Divider(),
            Row(children: [
              Expanded(
                  flex: 4,
                  child: Text("Product",
                      style: TextStyle(
                        fontSize: baseSize,  fontWeight: FontWeight.bold
                      ))),
              Expanded(
                flex: 2,
                  child:
                      Text("Qyt.", style: TextStyle(fontSize: baseSize,  fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Text("Price",
                      style: TextStyle(fontSize: baseSize, fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 2,
                  child: Text("Amount",
                      style: TextStyle(fontSize: baseSize,  fontWeight: FontWeight.bold))),
            ]),
            Divider(height: baseSize),
            SizedBox(height: baseSize * 2),
            ListView.builder(
                itemBuilder: (context, index) {
                  CartModel model = list[index];
                  return Row(children: [
                    Expanded(
                        flex: 4,
                        child: Text(model.item.name,
                            style: TextStyle(fontSize: baseSize))),
                    Expanded(
                      flex:2,
                        child: Text('${model.quantity}${model.item.unit}',
                            style: TextStyle(fontSize: baseSize))),
                    Expanded(
                        flex: 2,
                        child: Text(model.item.pricePerUnit.format,
                            style: TextStyle(fontSize: baseSize))),
                    Expanded(
                        flex: 2,
                        child: Text((model.item.pricePerUnit * model.quantity).format,
                            style: TextStyle(fontSize: baseSize))),
                  ]);
                },
                itemCount: list.length),
            SizedBox(height: baseSize),
            Divider(height: baseSize),
            Row( children: [
              Expanded(child: Text("Sub Total (SAR)", style: TextStyle(fontSize: baseSize)),),
              Text(total.format, style: TextStyle(fontSize: baseSize)),
              SizedBox(width: baseSize*3)
            ]),
            SizedBox(height: baseSize),
            if(discount > 0) ...[
              Row( children: [
                Expanded(child: Text("Discount (SAR)", style: TextStyle(fontSize: baseSize)),),
                Text(discount.format, style: TextStyle(fontSize: baseSize)),
                SizedBox(width: baseSize*3)
              ]),
              SizedBox(height: baseSize),
            ],
            Row( children: [
              Expanded(child: Text("Total Price (SAR)",
                  style: TextStyle(
                      fontSize: baseSize * 1.2, fontWeight: FontWeight.bold)),),
              Text((total.round() - discount.round()).formatRound,
                  style: TextStyle(
                      fontSize: baseSize * 1.2, fontWeight: FontWeight.bold)),
              SizedBox(width: baseSize*3)
            ]),
            SizedBox(height: baseSize * 4),
            Row(children: [
              Text("Payment Method: ", style: TextStyle(fontSize: baseSize)),
              SizedBox(width: baseSize * 3),
              Text(paymentType.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: baseSize * 1.2, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: baseSize * 4),
            BarcodeWidget(
                data: invoiceNo,
                barcode: Barcode.qrCode(typeNumber: 2),
                height: 40,
                width: 40)
          ]); // Center
        }));

    Get.dialog(PdfPreview(
        allowSharing: false,
        dynamicLayout: false,
        initialPageFormat: PdfPageFormat.roll80,
        pageFormats: const <String, PdfPageFormat>{
          'Roll 80': PdfPageFormat.roll80,
          'Roll 57': PdfPageFormat.roll57,
        },
        maxPageWidth: 400,
        dpi: 600.0,
        build: (format) {
          return doc.save();
        }));
    // await Printing.layoutPdf(onLayout: (format) => doc.save(),);
  }
}
