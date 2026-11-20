import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppCustomColors extends ThemeExtension<AppCustomColors> {
  final Color headerBackground;
  final Color headerCircle;
  final Color cardBackground;
  final Color cardShadow;
  final Color badgeBackground;
  final Color badgeText;
  final Color textMuted;
  final Color textPlaceholder;
  final Color inputBorder;
  final Color inputBorderFocused;
  final Color inputFill;
  final Color roleSwitchBackground;

  const AppCustomColors({
    required this.headerBackground,
    required this.headerCircle,
    required this.cardBackground,
    required this.cardShadow,
    required this.badgeBackground,
    required this.badgeText,
    required this.textMuted,
    required this.textPlaceholder,
    required this.inputBorder,
    required this.inputBorderFocused,
    required this.inputFill,
    required this.roleSwitchBackground,
  });

  @override
  AppCustomColors copyWith({
    Color? headerBackground,
    Color? headerCircle,
    Color? cardBackground,
    Color? cardShadow,
    Color? badgeBackground,
    Color? badgeText,
    Color? textMuted,
    Color? textPlaceholder,
    Color? inputBorder,
    Color? inputBorderFocused,
    Color? inputFill,
    Color? roleSwitchBackground,
  }) {
    return AppCustomColors(
      headerBackground: headerBackground ?? this.headerBackground,
      headerCircle: headerCircle ?? this.headerCircle,
      cardBackground: cardBackground ?? this.cardBackground,
      cardShadow: cardShadow ?? this.cardShadow,
      badgeBackground: badgeBackground ?? this.badgeBackground,
      badgeText: badgeText ?? this.badgeText,
      textMuted: textMuted ?? this.textMuted,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBorderFocused: inputBorderFocused ?? this.inputBorderFocused,
      inputFill: inputFill ?? this.inputFill,
      roleSwitchBackground: roleSwitchBackground ?? this.roleSwitchBackground,
    );
  }

  @override
  AppCustomColors lerp(ThemeExtension<AppCustomColors>? other, double t) {
    if (other is! AppCustomColors) return this;
    return AppCustomColors(
      headerBackground: Color.lerp(headerBackground, other.headerBackground, t)!,
      headerCircle: Color.lerp(headerCircle, other.headerCircle, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t)!,
      badgeText: Color.lerp(badgeText, other.badgeText, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputBorderFocused: Color.lerp(inputBorderFocused, other.inputBorderFocused, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      roleSwitchBackground: Color.lerp(roleSwitchBackground, other.roleSwitchBackground, t)!,
    );
  }

  static const light = AppCustomColors(
    headerBackground: Color(0xFF2D0F4E),
    headerCircle: Color(0xFF502257),
    cardBackground: Color(0xFFFFFFFF),
    cardShadow: Color(0x14201040),
    badgeBackground: Color(0x33FFFFFF),
    badgeText: Color(0xFFFFFFFF),
    textMuted: Color(0xFF605A6D),
    textPlaceholder: Color(0xFFA19BAE),
    inputBorder: Color(0xFFE0D8E8),
    inputBorderFocused: Color(0xFF6A249D),
    inputFill: Color(0xFFFFFFFF),
    roleSwitchBackground: Color(0xFFF7F4FA),
  );

  static const dark = AppCustomColors(
    headerBackground: Color(0xFF0E0717),
    headerCircle: Color(0xFF1D0F2E),
    cardBackground: Color(0xFF1E132D),
    cardShadow: Color(0x33000000),
    badgeBackground: Color(0x339D4EDD),
    badgeText: Color(0xFFE0AAFF),
    textMuted: Color(0xFFAFA5BE),
    textPlaceholder: Color(0xFF756C82),
    inputBorder: Color(0xFF3B2857),
    inputBorderFocused: Color(0xFF9D4EDD),
    inputFill: Color(0xFF251838),
    roleSwitchBackground: Color(0xFF251838),
  );
}

class AppTheme {
  AppTheme._();

  // Primary brand palette
  static const Color lightPrimary = Color(0xFF6A249D);
  static const Color lightPrimaryDark = Color(0xFF561A83);
  static const Color lightPrimaryLight = Color(0xFF8531C2);
  static const Color lightScaffold = Color(0xFFF7F4FA);

  static const Color darkPrimary = Color(0xFF9D4EDD);
  static const Color darkPrimaryDark = Color(0xFF7B2CBF);
  static const Color darkPrimaryLight = Color(0xFFC77DFF);
  static const Color darkScaffold = Color(0xFF120B1D);

  // LIGHT THEME
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      splashColor: lightPrimaryLight.withValues(alpha: 0.12),
      scaffoldBackgroundColor: lightScaffold,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: lightPrimary,
        onPrimary: Colors.white,
        primaryContainer: lightPrimaryLight,
        onPrimaryContainer: Colors.white,
        secondary: lightPrimaryDark,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xFF201C26),
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        outline: Color(0xFFE0D8E8),
        outlineVariant: lightPrimary,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(color: const Color(0xFF201C26), fontWeight: FontWeight.bold),
        titleLarge: baseTextTheme.titleLarge?.copyWith(color: const Color(0xFF201C26), fontWeight: FontWeight.w700),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: const Color(0xFF201C26), fontWeight: FontWeight.w600),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: const Color(0xFF201C26)),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: const Color(0xFF201C26)),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: const Color(0xFF605A6D)),
        labelLarge: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightPrimary,
          textStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFFA19BAE),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE0D8E8),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: lightPrimary,
            width: 1.5,
          ),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppCustomColors.light,
      ],
    );
  }

  // DARK THEME
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      splashColor: darkPrimaryLight.withValues(alpha: 0.15),
      scaffoldBackgroundColor: darkScaffold,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: darkPrimary,
        onPrimary: Colors.white,
        primaryContainer: darkPrimaryDark,
        onPrimaryContainer: Colors.white,
        secondary: darkPrimaryLight,
        onSecondary: Color(0xFF120B1D),
        surface: Color(0xFF1E132D),
        onSurface: Color(0xFFF1EBF7),
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        outline: Color(0xFF3B2857),
        outlineVariant: darkPrimary,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(color: const Color(0xFFF1EBF7), fontWeight: FontWeight.bold),
        titleLarge: baseTextTheme.titleLarge?.copyWith(color: const Color(0xFFF1EBF7), fontWeight: FontWeight.w700),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: const Color(0xFFF1EBF7), fontWeight: FontWeight.w600),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: const Color(0xFFF1EBF7)),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: const Color(0xFFF1EBF7)),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: const Color(0xFFAFA5BE)),
        labelLarge: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF1E132D),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimaryLight,
          textStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF251838),
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFF756C82),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF3B2857),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: darkPrimary,
            width: 1.5,
          ),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppCustomColors.dark,
      ],
    );
  }
}

extension AppThemeExtension on BuildContext {
  AppCustomColors get customColors =>
      Theme.of(this).extension<AppCustomColors>() ?? AppCustomColors.light;
}
