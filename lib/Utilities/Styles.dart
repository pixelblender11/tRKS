import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trks/Utilities/Utilities.dart';

class Styles {
  static final TextStyle? titleStyle=GoogleFonts.boldonse(
    fontSize: 48,
    textStyle: TextStyle(
      color: CustomColors.accentPink
    )
  );

  static final TextStyle? headerStyle=GoogleFonts.boldonse(
      fontSize: 32,
      textStyle: TextStyle(
          color: CustomColors.accentPink
      )
  );

  static final TextStyle? smallHeaderStyle=GoogleFonts.boldonse(
      fontSize: 22,
      textStyle: TextStyle(
          color: CustomColors.accentPink
      )
      //fontWeight: FontWeight.w600
  );

  static final TextStyle? largeBodyStyle=GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w400
  );

  static final TextStyle? bodyStyle=GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400
  );

}