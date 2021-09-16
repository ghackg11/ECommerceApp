import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product.dart';
import 'package:get/get.dart';

class GrocieriesProductController extends GetxController {
  var products = <Product>[].obs;

  DocumentSnapshot? lastProduct;

  @override
  void onInit() {
    fetchInitialData();
    super.onInit();
  }

  @override
  void dispose() {
    products.clear();
    super.dispose();
  }

  fetchInitialData() async {
    FirebaseFirestore database = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await database
        .collection("Products")
        .where("productCategory", isEqualTo: "Groceries")
        .limit(10)
        .get();

    lastProduct = snapshot.docs.last;

    for (DocumentSnapshot doc in snapshot.docs) {
      products.add(Product(
          doc['productId'],
          doc['productCategory'],
          doc['productName'],
          doc['productDesc'],
          doc['productImage'],
          doc['price'],
          doc['quantity'],
          doc['searchParams']));
    }
  }

  fetchMoreData() async {
    FirebaseFirestore database = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await database
        .collection("Products")
        .where("productCategory", isEqualTo: "Groceries")
        .limit(10)
        .startAtDocument(lastProduct)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      products.add(Product(
          doc['productId'],
          doc['productCategory'],
          doc['productName'],
          doc['productDesc'],
          doc['productImage'],
          doc['price'],
          doc['quantity'],
          doc['searchParams']));
    }
  }
}
