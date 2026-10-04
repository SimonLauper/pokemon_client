import 'package:flutter/material.dart';

/// Identité visuelle « Pokédex » : coque rouge, lentille bleue, écran clair
/// et une couleur propre à chaque type de Pokémon.
class PokedexTheme {
  PokedexTheme._();

  // Coque du Pokédex
  static const Color red = Color(0xFFDC0A2D);
  static const Color redDark = Color(0xFF9E0620);
  static const Color redLight = Color(0xFFF2425F);

  // Lentille et voyants
  static const Color lensBlue = Color(0xFF29A9FF);
  static const Color lensBlueDark = Color(0xFF0B5FC4);
  static const Color ledRed = Color(0xFFFF6B6B);
  static const Color ledYellow = Color(0xFFFFCB05);
  static const Color ledGreen = Color(0xFF3DDC84);

  // Écran
  static const Color screenBg = Color(0xFFF2F3F8);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE2E5EF);

  static const Color ink = Color(0xFF1D1F2B);
  static const Color inkMuted = Color(0xFF6B7185);

  static const LinearGradient shellGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [redLight, red, redDark],
    stops: [0, 0.45, 1],
  );

  static const Color _fallbackType = Color(0xFFA8A77A);

  static const Map<String, Color> _typeColors = {
    'acier': Color(0xFFB7B7CE),
    'combat': Color(0xFFC22E28),
    'dragon': Color(0xFF6F35FC),
    'eau': Color(0xFF6390F0),
    'électrik': Color(0xFFF7D02C),
    'fée': Color(0xFFD685AD),
    'feu': Color(0xFFEE8130),
    'glace': Color(0xFF96D9D6),
    'insecte': Color(0xFFA6B91A),
    'normal': _fallbackType,
    'plante': Color(0xFF7AC74C),
    'poison': Color(0xFFA33EA1),
    'psy': Color(0xFFF95587),
    'roche': Color(0xFFB6A136),
    'sol': Color(0xFFE2BF65),
    'spectre': Color(0xFF735797),
    'ténèbres': Color(0xFF705746),
    'vol': Color(0xFFA98FF3),
  };

  static Color typeColor(String type) {
    return _typeColors[type.toLowerCase()] ?? _fallbackType;
  }

  /// Version plus sombre de la couleur du type, utile pour les dégradés
  /// et les accents posés sur fond clair.
  static Color typeColorDark(String type, [double amount = 0.22]) {
    return Color.lerp(typeColor(type), Colors.black, amount)!;
  }

  static LinearGradient typeGradient(String type) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [typeColor(type), typeColorDark(type)],
    );
  }

  /// Couleur lisible (blanc ou encre) pour du texte posé sur la couleur du type.
  static Color onTypeColor(String type) {
    return typeColor(type).computeLuminance() > 0.45 ? ink : Colors.white;
  }

  static Color statColor(int value) {
    if (value >= 120) return const Color(0xFF2DD4BF);
    if (value >= 90) return const Color(0xFF4ADE80);
    if (value >= 60) return const Color(0xFFFACC15);
    if (value >= 40) return const Color(0xFFFB923C);
    return const Color(0xFFF87171);
  }

  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle pokemonNameStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle sectionLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: inkMuted,
    letterSpacing: 1.4,
  );

  static ThemeData get themeData {
    final scheme = ColorScheme.fromSeed(
      seedColor: red,
      brightness: Brightness.light,
    ).copyWith(primary: red, onPrimary: Colors.white, surface: surface);

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: screenBg,
      textTheme: base.textTheme.apply(bodyColor: ink, displayColor: ink),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: red),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
