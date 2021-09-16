class Product {
  String productId;
  String productCategory;
  String productName;
  String productDesc;
  String productImage;
  int price;
  int quantity;
  List<dynamic> searchParams;

  Product(
      this.productId,
      this.productCategory,
      this.productName,
      this.productDesc,
      this.productImage,
      this.price,
      this.quantity,
      this.searchParams);
}
