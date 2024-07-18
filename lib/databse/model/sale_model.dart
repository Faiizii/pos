class Sale {
  final int id;
  final String paymentMethod;
  final String? createdAt;
  final double discount;
  final double saleAmount;
  final String? customerName;
  final String? customerPhoneNumber;
  final int shopId;

  Sale({
    required this.id,
    required this.paymentMethod,
    this.createdAt,
    required this.discount,
    required this.saleAmount,
    this.customerName,
    this.customerPhoneNumber,
    this.shopId = 1,
  });

  // Convert a Sale object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod,
      'discount': discount,
      'sale_amount': saleAmount,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'shop_id': shopId,
    };
  }

  // Convert a Map object into a Sale object
  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] ?? 0,
      paymentMethod: map['payment_method'],
      createdAt: map['created_at'],
      discount: map['discount'],
      saleAmount: map['sale_amount'],
      customerName: map['customer_name'],
      customerPhoneNumber: map['customer_phone_number'],
      shopId: map['shop_id'],
    );
  }
}
