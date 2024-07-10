class SaleTable {
  static const String tableName = "sale";
  static const createStatement = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "paymentMethod VARCHAR(10) CHECK(paymentMethod IN ('cash', 'card')) NOT NULL,"
      "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
      "discount DECIMAL(5, 2) DEFAULT 0.00,"
      "saleAmount DECIMAL(10, 2) NOT NULL,"
      "customerName VARCHAR(255),"
      "customerPhoneNumber VARCHAR(20),"
      "shopID INTEGER DEFAULT 1"
    ");";
}