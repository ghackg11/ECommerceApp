import 'package:ecommerce/constants.dart';
import 'package:ecommerce/controllers/cart_controller.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/views/category_products_page.dart';
import 'package:ecommerce/views/shopping_page.dart';
import 'package:ecommerce/views/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cart_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Store',
            style: GoogleFonts.montserrat(),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(FeatherIcons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FeatherIcons.bell),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(FeatherIcons.shoppingBag),
              ),
              Tab(
                icon: Icon(FeatherIcons.shoppingCart),
              ),
              Tab(
                icon: Icon(FeatherIcons.heart),
              ),
              Tab(
                icon: Icon(FeatherIcons.user),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.dstATop),
                                fit: BoxFit.cover,
                                image: NetworkImage(FirebaseAuth
                                    .instance.currentUser.photoURL)),
                            color: Colors.black),
                        accountName: Text(
                          FirebaseAuth.instance.currentUser.displayName,
                          style: GoogleFonts.montserrat(),
                        ),
                        accountEmail: Text(
                          FirebaseAuth.instance.currentUser.email,
                          style: GoogleFonts.montserrat(),
                        )),
                    for (int i = 0; i < Category.titles.length; i++)
                      ListTile(
                        leading: Icon(Category.icons[i]),
                        onTap: (){
                          Get.to(CategoryProductsPage(category: Category.titles[i]));
                        },
                        title: Text(
                          Category.titles[i],
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () async {
                      await _googleSignIn.signOut();
                      await _auth.signOut();
                      Get.deleteAll();
                      Get.offAll(LoginPage());
                    },
                    child: Text('LogOut', style: GoogleFonts.montserrat(color: primaryColor, fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: const RangeMaintainingScrollPhysics(),
          children: <Widget>[
            ShoppingPage(),
            const CartPage(),
            const WishListPage(),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
