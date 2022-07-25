import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors/colors.dart';

//AppTheme

var themeData = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
);
