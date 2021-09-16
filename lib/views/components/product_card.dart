import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/controllers/wishlist_controller.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.pro,
  }) : super(key: key);

  final Product pro;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              GetX<CartController>(builder: (controller) {
                return IconButton(
                    onPressed: () {
                      var item = CartItem(pro, 1);
                      controller.cartClicked(item);
                    },
                    icon: (controller.cartItems.any(
                            (element) => element.p.productId == pro.productId))
                        ? Icon(
                      Icons.shopping_cart,
                    )
                        : Icon(Icons.add_shopping_cart));
              }),
              GetX<WishListController>(
                  builder: (controller) {
                    return IconButton(
                        onPressed: () {
                          controller.heartClicked(pro);
                        },
                        icon: Icon(
                          FeatherIcons.heart,
                          color:
                          controller.wishList.any((element) => element.productId==pro.productId)
                              ? Colors.red
                              : Colors.black,
                        ));
                  }),
            ],
          ),
          Image.network(
            pro.productImage,
            height: 100,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                pro.productName,
                style: GoogleFonts.montserrat(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rs.${pro.price}",
                style: GoogleFonts.montserrat(),
              )),
        ],
      ),
    );
  }
}
