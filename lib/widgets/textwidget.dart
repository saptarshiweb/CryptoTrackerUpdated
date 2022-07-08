import 'package:flutter/material.dart';

Text t(String s, double size, Color color) {
  return Text(
    s,
    style:
        TextStyle(color: color, fontSize: size, fontWeight: FontWeight.normal),
  );
}

Text tb(String s, double size, Color color) {
  return Text(
    s,
    style: TextStyle(
        fontFamily: 'lat',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold),
  );
}
