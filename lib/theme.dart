import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterFeedTheme {
  static ThemeData light(BuildContext context) {
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: Theme.of(context).iconTheme,
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(),
        cardTheme: Theme.of(context).cardTheme.copyWith(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  color: Colors.grey[400]!,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
        bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
              elevation: 0,
            ));
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFF13B9FF),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      toggleableActiveColor: const Color(0xFF13B9FF),
    );
  }

  static double paddingPxMH = 8.0;
  static double paddingPxH = 16.0;

  static SizedBox separatorH() => const SizedBox(
        width: 16,
      );

  static SizedBox separatorMH() => const SizedBox(
        width: 8,
      );

  static SizedBox separatorV() => const SizedBox(
        width: 16,
      );
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
