import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() async {
    List<DocumentSnapshot> doc = (await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("Cart")
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
      cartItems.add(CartItem(p, doc[i]['quantity']));
    }

    super.onInit();
  }

  @override
  void refresh() {
    onInit();
  }

  @override
  void dispose() {
    cartItems.clear();
    super.dispose();
  }

  void increaseQty(int index) async {
    var temp = cartItems[index];
    cartItems.removeAt(index);
    temp.qty++;
    cartItems.insert(index, temp);
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Cart")
        .where('productId', isEqualTo: temp.p.productId)
        .snapshots()
        .first;
    List<DocumentSnapshot> docs = snap.docs;
    docs[0].reference.update({'quantity': FieldValue.increment(1)});
  }

  void decreaseQty(int index) async {
    var temp = cartItems[index];
    cartItems.removeAt(index);
    temp.qty--;
    cartItems.insert(index, temp);
    if (temp.qty <= 0) {
      removeItemFromCart(temp);
    }
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Cart")
        .where('productId', isEqualTo: temp.p.productId)
        .get();
    List<DocumentSnapshot> docs = snap.docs;
    docs[0].reference.update({
      'quantity': FieldValue.increment(-1),
    });
  }

  void cartClicked(CartItem item) {
    // print(item.p.productId);
    if (!cartItems.any((element) => element.p.productId == item.p.productId)) {
      addItemToCart(item);
    } else {
      removeItemFromCart(item);
    }
  }

  void addItemToCart(CartItem item) {
    cartItems.add(item);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("Cart")
        .add({'productId': item.p.productId, 'quantity': 1});
    showSnackBar("Task Successful!", "Product added to the cart");
  }

  void removeItemFromCart(CartItem item) async {
    cartItems.removeWhere((element) => element.p.productId == item.p.productId);
    List<DocumentSnapshot> docs = (await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("Cart")
            .where('productId', isEqualTo: item.p.productId)
            .get())
        .docs;
    docs[0].reference.delete();
    showSnackBar("Task Successful!", "Product removed from the cart");
  }
}
