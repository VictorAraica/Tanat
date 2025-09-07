import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffBBDD8F);
const Color darkColor = Color(0xFF101010);
const Color darkColorWithOpacity = Color(0x7b101010);
const Color whiteColor = Color(0xFFEFEFEF);

const double minimumBottomSpace = 20.0;

const double horizontalPadding = 20;
const int maxLengthPhone = 10;

const ShapeBorder shapeForBottomSheet = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

const Gradient backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.centerRight,
  colors: [Color(0xFF00967B), Color(0xFF00446D)],
);

const double dropdownWidth = 0.8;
const double dropdownHeight = 0.5;
