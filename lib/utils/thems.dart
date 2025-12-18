import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TheamsModeData {
  //light mode
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.openSans().fontFamily,
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontFamily: GoogleFonts.openSans().fontFamily),
    ),
  );

  //dark mode
  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.openSans().fontFamily,
  );
}
