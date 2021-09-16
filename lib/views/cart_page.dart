import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: controller.cartItems.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, i) {
                          return CartItemCard(
                            i: i,
                            controller: controller,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      height: 90,
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Buy Now',
                          style: GoogleFonts.montserrat(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text('No items in the cart', style: GoogleFonts.montserrat(fontSize: 16),),
                ),
        );
      },
    );
  }
}
