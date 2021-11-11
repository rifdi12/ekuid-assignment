import 'package:flutter/material.dart';

ThemeData themeData() {
  Color greyTextTitle = const Color(0xFF757575);
  Color greyText = const Color(0xFF5b5b5b);

  return ThemeData(
    canvasColor: Colors.white,
    primarySwatch: Colors.blue,
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: greyTextTitle),
    ),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 20),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: 12.0, color: greyText),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        textTheme: ButtonTextTheme.primary,
        height: 40),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    ),
  );
}
