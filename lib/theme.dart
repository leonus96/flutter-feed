import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterNewsTheme {
  static ThemeData light(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          systemOverlayStyle: SystemUiOverlayStyle.dark),
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
      )
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xFF13B9FF),
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
