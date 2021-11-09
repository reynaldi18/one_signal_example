import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color mainColor = Color(0xFF007BFF);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF020202);
const Color blackSoft = Color(0xFF535353);
const Color grey = Color(0xFF8D92A3);
const Color greySoft = Color(0xFFC4C4C4);
const Color failed = Color(0xFFF05B5D);
const Color success = Color(0xFF1ABC9C);

const Color hint = Color(0xFFBABABA);
const Color facebookColor = Color(0xFF1976D2);

// TextStyle
TextStyle mainTextStyle = GoogleFonts.poppins(color: mainColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: white);
TextStyle blackTextStyle = GoogleFonts.poppins(color: black);
TextStyle blackSoftTextStyle = GoogleFonts.poppins(color: blackSoft);
TextStyle greyTextStyle = GoogleFonts.poppins(color: grey);
TextStyle greySoftTextStyle = GoogleFonts.poppins(color: greySoft);

// Theme
BoxShadow shadow = const BoxShadow(
  color: Colors.black26,
  blurRadius: 3,
  offset: Offset(0, 5),
);
