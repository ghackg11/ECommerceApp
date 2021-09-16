import 'package:ecommerce/controllers/groceries_product_controller.dart';
import 'package:ecommerce/controllers/household_product_controller.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/views/components/household_products.dart';
import 'package:ecommerce/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/grocery_products.dart';

class CategoryProductsPage extends StatefulWidget {
  String category;

  CategoryProductsPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  GrocieriesProductController categoryProductController = Get.find();
  HouseholdProductController householdProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    //if category==grocieries

    switch (widget.category) {
      case 'Groceries':
        {
          return  GroceryProducts();
        }
      case 'Household':
        {
          return  HouseholdProducts();
        }

      default:
        {
          return Material(
            child: Center(
                child: Text(
              'Invalid Category',
              style: GoogleFonts.montserrat(),
            )),
          );
        }
    }
  }
}
