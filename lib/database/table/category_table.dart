class CategoryTable {
  static const String tableName = "category";
  static const String createStatement = "CREATE TABLE $tableName ("
    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
    "name VARCHAR(255) NOT NULL,"
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
    "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP"
  ");";
}