import 'package:get/get.dart';
import 'package:pos/extensions/num_extension.dart';
import 'package:pos/ui/cart/cart_board_controller.dart';
import 'package:pos/ui/cart/cart_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class RecieptManager {
  void printReceipt(List<CartModel> list, String invoiceNo, double total, PaymentType paymentType) async {
    final doc = Document();

    double baseSize = 4; //heading will be multiply with 1.5

    var image = await imageFromAssetBundle("images/logo.jpeg");
    doc.addPage(Page(
        pageFormat: PdfPageFormat.roll80,
        build: (Context context) {
          return Column(children: [
            Image(image, width: baseSize*4, height: baseSize*4),
            Text("Al Reem Meat Shop", style: TextStyle(fontSize: baseSize * 1.5)),
            Text("Al Murqeen Street 22, Madinatul Umal", style: TextStyle(fontSize: baseSize * 1.5)),
            Text("Al Khobar", style: TextStyle(fontSize: baseSize * 1.5)),
            Divider(),
            Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Invoice# ", style: TextStyle(fontSize: baseSize, fontWeight: FontWeight.bold)),
                Text("Date ", style: TextStyle(fontSize: baseSize, fontWeight: FontWeight.bold)),
              ])),
              Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(invoiceNo, style: TextStyle(fontSize: baseSize)),
                Text(DateTime.now().toString(), style: TextStyle(fontSize: baseSize))
              ]))
            ]),
            Divider(),
            Row(children: [
              Expanded(flex: 4, child: Text("Product", style: TextStyle(fontSize: baseSize * 1.5,))),
              Expanded(child: Text("Qyt.", style: TextStyle(fontSize: baseSize * 1.5))),
              Expanded(flex: 2, child: Text("Price", style: TextStyle(fontSize: baseSize * 1.5))),
              Expanded(flex: 2, child: Text("Amount", style: TextStyle(fontSize: baseSize * 1.5))),
            ]),

            Divider(height: baseSize),

            SizedBox(height: baseSize*2),

            ListView.builder(itemBuilder: (context, index){
              CartModel model = list[index];
              return Row(children: [
                Expanded(flex: 4, child: Text(model.name, style: TextStyle(fontSize: baseSize))),
                Expanded(child: Text(model.quantity.toString(), style: TextStyle(fontSize: baseSize))),
                Expanded(flex: 2, child: Text(model.rate.format, style: TextStyle(fontSize: baseSize))),
                Expanded(flex: 2, child: Text((model.rate * model.quantity).format, style: TextStyle(fontSize: baseSize))),
              ]);
            }, itemCount: list.length),

            SizedBox(height: baseSize),

            Divider(height: baseSize),

            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children: [
              Text("Sub Total", style: TextStyle(fontSize: baseSize)),
              Text(total.formatRound, style: TextStyle(fontSize: baseSize))
            ]),
            SizedBox(height: baseSize),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween, children: [
              Text("Total Price", style: TextStyle(fontSize: baseSize * 1.2, fontWeight: FontWeight.bold)),
              Text(total.round().formatRound, style: TextStyle(fontSize: baseSize * 1.2, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: baseSize * 4),
            Row(children: [
              Text("Payment Method: ", style: TextStyle(fontSize: baseSize)),
              SizedBox(width: baseSize*3),
              Text(paymentType.name.toUpperCase(), style: TextStyle(fontSize: baseSize * 1.2, fontWeight: FontWeight.bold))
            ]),

            BarcodeWidget(data: "1234523", barcode: Barcode.qrCode(typeNumber: 40), height: 40, width: 40)
          ]); // Center
        }
    ));

    Get.dialog(PdfPreview(
      allowSharing: false,
      dynamicLayout: false,
      initialPageFormat: PdfPageFormat.roll80,
      pageFormats: const <String, PdfPageFormat>{
        'Roll 80': PdfPageFormat.roll80,
        'Roll 57': PdfPageFormat.roll57,
      } ,
        maxPageWidth: 200,

        dpi: 220.0,
      build: (format){
        return doc.save();
      }
    ));
    // await Printing.layoutPdf(onLayout: (format) => doc.save(),);
  }

}