import 'package:flutter/material.dart';

class AppWidget {
  //FONT STYLE FOR BOLD TEXT
  static TextStyle boldTextfieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 23,
      fontWeight: FontWeight.bold,
    );
  }

  //FONT STLYLE FOR LIGHT TEXT
  static TextStyle lightTextfieldStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  //FONT STLYLE FOR SEMI BOLD TEXT
  static TextStyle semiboldTextfieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }
}
