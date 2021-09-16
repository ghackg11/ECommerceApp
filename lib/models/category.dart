import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Category {
  static List<String> titles = [
    "Household",
    "Groceries",
    "Liquor",
    "Chilled",
    "Furniture",
    "Computer"
  ];
  static List<IconData> icons = [
    FeatherIcons.home,
    FeatherIcons.shoppingCart,
    FeatherIcons.home,
    Icons.fastfood_outlined,
    Icons.bed_outlined,
    Icons.computer
  ];
}
