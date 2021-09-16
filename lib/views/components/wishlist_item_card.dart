import 'package:ecommerce/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishListItemCard extends StatelessWidget {
  WishListController controller;
  int i;

  WishListItemCard({Key? key, required this.controller, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${controller.wishList[i].productId}'),
      onDismissed: (direction) {
        controller.heartClicked(controller.wishList[i]);
      },
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.red.shade200),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              child: Image.network(
                controller.wishList[i].productImage,
                width: 80,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.wishList[i].productName,
                      style: GoogleFonts.montserrat(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rs.${controller.wishList[i].price}",
                      style: GoogleFonts.montserrat(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
