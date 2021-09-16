import 'package:ecommerce/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/wishlist_item_card.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<WishListController>(
      builder: (controller) {
        return controller.wishList.isNotEmpty
            ?Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemCount: controller.wishList.length,
            itemBuilder: (context, i){
              return WishListItemCard(controller: controller, i: i,);
            },
          ),
        ): Center(
          child: Text('No items in the wish-list', style: GoogleFonts.montserrat(fontSize: 16),),
        );
      }
    );
  }
}

