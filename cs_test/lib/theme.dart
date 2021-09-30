import 'dart:ui';
import 'package:flutter/material.dart';

const Map<int, Color> _primarySwatch = {
  50: Color(0xeaf4f4),
  100: Color(0xcae4e3),
  200: Color(0xa7d2d0),
  300: Color(0x84bfbd),
  400: Color(0x69b2af),
  500: Color(0x4fa4a1),
  600: Color(0x489c99),
  700: Color(0x3f928f),
  800: Color(0x368985),
  900: Color(0x267874),
};

const Map<int, Color> accentSwatch = {
  25: Color(0xFFeeeef6),
  50: Color(0xFFDBDBE6),
  75: Color(0xFF869fc0),
  100: Color(0xFF7778AC),
};

const Map<int, Color> _emphasisSwatch = {
  50: Color(0xfef2e5),
  100: Color(0xfee0be),
  200: Color(0xfdcb93),
  300: Color(0xfcb668),
  400: Color(0xfba647),
  500: Color(0xfa9627),
  600: Color(0xf98e23),
  700: Color(0xf9831d),
  800: Color(0xf87917),
  900: Color(0xf6680e),
};

const MaterialColor _primaryMaterialColor =
    const MaterialColor(0x4fa4a1, _primarySwatch);

const Color _primaryColor = const Color.fromARGB(255, 79, 164, 161);
const Color _accentColor = const Color.fromARGB(255, 90, 91, 159);
const Color _warnColor = const Color.fromARGB(255, 211, 47, 47);
const Color _whiteColor = const Color.fromARGB(255, 255, 255, 255);

const Color _textColor = const Color.fromARGB(255, 38, 50, 56);
const Color _onPrimaryColor = const Color.fromARGB(255, 255, 255, 255);
const Color _onAccentColor = const Color.fromARGB(255, 255, 255, 255);

const Color csGrey = const Color(0xFF707070);
const Color csLightPrimary = const Color(0xFFeff8f7);

const Gradient csVerticalGradient = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    _primaryColor,
    _accentColor,
  ],
);
const Gradient csHorizontalGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [
    _primaryColor,
    _accentColor,
  ],
);
const Gradient csAngleGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment(1.5, 0.3),
  colors: [
    _primaryColor,
    _accentColor,
  ],
);

ThemeData buildTheme(BuildContext context) =>
    ThemeData(primarySwatch: _primaryMaterialColor).copyWith(
      colorScheme: ColorScheme(
          primary: _primaryColor,
          primaryVariant: _primarySwatch[900],
          secondary: _accentColor,
          secondaryVariant: _emphasisSwatch[900],
          error: _warnColor,
          surface: _whiteColor,
          background: _whiteColor,
          onBackground: _textColor,
          onPrimary: _onPrimaryColor,
          onSecondary: _onPrimaryColor,
          onError: _onPrimaryColor,
          onSurface: _textColor,
          brightness: Brightness.light),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            color: _whiteColor,
            iconTheme: ThemeData.light().iconTheme.copyWith(
                  color: _primaryColor,
                ),
          ),
      iconTheme: ThemeData.light().iconTheme.copyWith(
            color: _primaryColor,
          ),
      buttonTheme: ThemeData.light().buttonTheme.copyWith(
            buttonColor: _primaryColor,
            textTheme: ButtonTextTheme.primary,
          ),
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      errorColor: _warnColor,
      scaffoldBackgroundColor: _whiteColor,
      indicatorColor: _primaryColor,
      textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: _textColor,
          decorationColor: _textColor,
          displayColor: _textColor),
      primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: _accentColor,
          decorationColor: _accentColor,
          displayColor: _accentColor),
      accentTextTheme: ThemeData.light().accentTextTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: _onAccentColor,
          decorationColor: _onAccentColor,
          displayColor: _onAccentColor),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
