import 'package:flutter/material.dart';

class Swing {
  static const MaterialColor smoothgreen = MaterialColor(
    0xff80a571, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff739566), //10%
      100: Color(0xff66845a), //20%
      200: Color(0xff5a734f), //30%
      300: Color(0xff4d6344), //40%
      400: Color(0xff405339), //50%
      500: Color(0xff33422d), //60%
      600: Color(0xff263122), //70%
      700: Color(0xff1a2117), //80%
      800: Color(0xff0d100b), //90%
      900: Color(0xff000000), //100%
    },
  );
}
