import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


TextStyle openSans(
  double fontSize,
  Color color,
  FontWeight fontWeight, {
  bool underline = false,
  bool overline = false,
  Color decorationColor = Colors.black,
}) {
  return GoogleFonts.openSans(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    decoration: underline != false
        ? TextDecoration.underline
        : overline != false
            ? TextDecoration.lineThrough
            : TextDecoration.none,
    decorationColor: decorationColor,
  );
}
