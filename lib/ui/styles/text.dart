import 'package:flutter/material.dart';

const Map<String, Color> textColors = {
    'black': Colors.black,
    'primary': const Color(0xFF1b2733),
    'secondary': const Color(0xFF637282),
    'hint': const Color(0xFF637282),
};

TextStyle header2TextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
    color: textColors['black']
);

TextStyle header4TextStyle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: textColors['black'],
);

TextStyle subhead = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: textColors['black'],
);

TextStyle body1TextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.05,
  color: textColors['primary']
);

TextStyle body2TextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.05,
    height: 1.1,
    color: textColors['secondary']
);

TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: textColors['primary']
);

TextStyle inputTextStyle = TextStyle(
    fontSize: 24.0,
    color: Colors.blueGrey[900]
);

TextStyle inputTextStyle2 = TextStyle(
    fontSize: 18.0,
    color: Colors.blueGrey[900]
);