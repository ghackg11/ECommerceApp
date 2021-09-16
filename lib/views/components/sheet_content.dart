
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/views/category_products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class SheetContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Categories',
                style: GoogleFonts.montserrat(fontSize: 16),
              )),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 0.65,
              children: [
                for (int i = 0; i < Category.titles.length; i++)
                  GestureDetector(
                    onTap: (){
                      Get.to(CategoryProductsPage(category: Category.titles[i]));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Category.icons[i],
                            color: primaryColor,
                          ),
                          backgroundColor: primaryColor.withOpacity(0.2),
                          radius: 35,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          Category.titles[i],
                          style: GoogleFonts.montserrat(),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
