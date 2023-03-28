import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE0F7F4),
  100: Color(0xFFB3ECE4),
  200: Color(0xFF80DFD3),
  300: Color(0xFF4DD2C1),
  400: Color(0xFF26C9B3),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF00B99E),
  700: Color(0xFF00B195),
  800: Color(0xFF00A98B),
  900: Color(0xFF009B7B),
});
const int _primaryPrimaryValue = 0xFF00BFA6;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFC6FFF1),
  200: Color(_primaryAccentValue),
  400: Color(0xFF60FFD8),
  700: Color(0xFF47FFD2),
});
const int _primaryAccentValue = 0xFF93FFE5;
