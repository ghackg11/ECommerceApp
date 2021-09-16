import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor =  Colors.redAccent;

void showSnackBar(String title, String message) {
  Get.showSnackbar(
      GetBar(
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        titleText: Text(title,style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
        messageText: Text(message,style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12),),
      )
  );
}