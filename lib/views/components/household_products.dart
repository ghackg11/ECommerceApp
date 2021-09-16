import 'package:ecommerce/controllers/groceries_product_controller.dart';
import 'package:ecommerce/controllers/household_product_controller.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../category_products_page.dart';
import 'product_card.dart';

class HouseholdProducts extends StatefulWidget {
   HouseholdProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<HouseholdProducts> createState() => _HouseholdProductsState();
}

class _HouseholdProductsState extends State<HouseholdProducts> {
  ScrollController scrollController = ScrollController();

  HouseholdProductController householdProductController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

   void _scrollListener() {
     if (scrollController.offset >= scrollController.position.maxScrollExtent &&
         !scrollController.position.outOfRange) {
       print("at the end of list");
       householdProductController.fetchMoreData();
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.red,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Household',
            style: GoogleFonts.montserrat(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: GetX<HouseholdProductController>(builder: (controller) {
          return GridView.count(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            childAspectRatio: 0.8,
            crossAxisCount: 2,
            children: [
              for (Product p in controller.products) ProductCard(pro: p)
            ],
          );
        }));
  }
}
