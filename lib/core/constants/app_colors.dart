import 'package:flutter/material.dart';

class AppColors {
  static final Map<int, Color> _colorCodes = {
    50: const Color.fromRGBO(28, 178, 177, .1),
    100: const Color.fromRGBO(28, 178, 177, .2),
    200: const Color.fromRGBO(28, 178, 177, .3),
    300: const Color.fromRGBO(28, 178, 177, .4),
    400: const Color.fromRGBO(28, 178, 177, .5),
    500: const Color.fromRGBO(28, 178, 177, .6),
    600: const Color.fromRGBO(28, 178, 177, .7),
    700: const Color.fromRGBO(28, 178, 177, .8),
    800: const Color.fromRGBO(28, 178, 177, .9),
    900: const Color.fromRGBO(28, 178, 177, 1),
  };

  static MaterialColor primary = MaterialColor(0XFF1CB2B1, _colorCodes);
}
