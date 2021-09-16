import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WishListController extends GetxController {
  var wishList = <Product>[].obs;

  void heartClicked(Product p) async {
    if (wishList.any((element) => element.productId == p.productId)) {
      wishList.removeWhere((elem) => elem.productId == p.productId);
      showSnackBar("Task Successful!", "Product removed from the wish-list");
      List<DocumentSnapshot> docs = (await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("Wishlist")
              .where('productId', isEqualTo: p.productId)
              .get())
          .docs;
      docs[0].reference.delete();
    } else {
      wishList.add(p);
      showSnackBar("Task Successful!", "Product added to the wish-list");
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("Wishlist")
          .add({'productId': p.productId, 'timeStamp': DateTime.now()});
    }
  }

  @override
  void refresh() {
    onInit();
  }

  @override
  void dispose() {
    wishList.clear();
    super.dispose();
  }

  @override
  void onInit() async {
    List<DocumentSnapshot> doc = (await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("Wishlist")
            .get())
        .docs;
    for (int i = 0; i < doc.length; i++) {
      DocumentSnapshot d = await FirebaseFirestore.instance
          .collection("Products")
          .doc(doc[i]['productId'])
          .get();
      Product p = Product(
          d['productId'],
          d['productCategory'],
          d['productName'],
          d['productDesc'],
          d['productImage'],
          d['price'],
          d['quantity'],
          d['searchParams']);
      wishList.add(p);
    }

    super.onInit();
  }
}
