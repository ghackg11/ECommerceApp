import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/groceries_product_controller.dart';
import 'package:ecommerce/controllers/household_product_controller.dart';
import 'package:ecommerce/controllers/wishlist_controller.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'components/grabbing_widget_sheet.dart';
import 'components/product_card.dart';
import 'components/sheet_content.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({Key? key}) : super(key: key);

  final snappingSheetController = SnappingSheetController();
  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());
  final groceriesController = Get.put(GrocieriesProductController());
  final householdController = Get.put(HouseholdProductController());

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
        // child: Container(color: Colors.yellow, height: 10,),
        controller: snappingSheetController,
        // grabbing: Container(height: 10,),
        grabbingHeight: 19,
        grabbing: GrabbingWidget(),

        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 200),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("HomePage").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> docs =
                        (snapshot.data as QuerySnapshot).docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, i) {
                        return Image.network(docs[i]['image']);
                      },
                    );
                  }
                  return LinearProgressIndicator(color: primaryColor,backgroundColor: primaryColor.shade400,);
                },
              ),
            )
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
        snappingPositions: [
          const SnappingPosition.factor(
            positionFactor: 0.7,
            snappingCurve: Curves.easeOutExpo,
            snappingDuration: Duration(seconds: 1),
            // grabbingContentOffset: GrabbingContentOffset.top,
          ),
          const SnappingPosition.factor(
            positionFactor: 0.5,
            snappingCurve: Curves.elasticOut,
            snappingDuration: Duration(milliseconds: 1750),
          ),
        ],
        initialSnappingPosition:
            const SnappingPosition.factor(positionFactor: 0.7),
        // lockOverflowDrag: true,
        sheetAbove: SnappingSheetContent(
            sizeBehavior: const SheetSizeFill(),
            draggable: true,
            child: SheetContent()),
        sheetBelow: null);
  }
}
