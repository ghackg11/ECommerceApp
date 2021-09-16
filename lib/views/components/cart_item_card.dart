import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatelessWidget {
  CartController controller;
  int i;

  CartItemCard({Key? key, required this.controller, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            child: Image.network(
              controller.cartItems[i].p.productImage,
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
                    controller.cartItems[i].p.productName,
                    style: GoogleFonts.montserrat(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Rs.${controller.cartItems[i].p.price}",
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.increaseQty(i);
                              },
                              icon: Icon(Icons.add),
                            ),
                            Container(
                              color: Colors.grey.shade200,
                              padding: const EdgeInsets.all(2),
                              width: 30,
                              child: Center(
                                child: Text(
                                  '${controller.cartItems[i].qty}',
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.decreaseQty(i);
                              },
                              icon: Icon(FeatherIcons.minus),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
