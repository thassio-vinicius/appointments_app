import 'package:flutter/widgets.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    String clearString = hexColor.toUpperCase().replaceAll('#', '');
    if (clearString.length == 6) {
      clearString = 'FF$clearString';
    }
    return int.parse(clearString, radix: 16);
  }
}
