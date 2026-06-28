import 'package:flutter/material.dart';

class DarkGlass {
  DarkGlass._();

  static const Color pageBg = Color(0xFF0D0D1A);
  static const Color headerBg = Color(0xFF16213E);
  static const Color cardBg = Color(0x0DFFFFFF);
  static const Color cardBgHover = Color(0x1AFFFFFF);
  static const Color infoTileBg = Color(0x0AFFFFFF);

  static const Color accentPurple = Color(0xFFA78BFA);
  static const Color accentBlue = Color(0xFF38BDF8);

  static const Color cardBorder = Color(0x33A78BFA);
  static const Color headerBorder = Color(0x14FFFFFF);
  static const Color filterBorder = Color(0x4DA78BFA);

  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textFaint = Color(0x40FFFFFF);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentPurple, accentBlue],
  );

  static const LinearGradient heroGlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x0038BDF8), Color(0x3338BDF8), Color(0x0038BDF8)],
  );

  static const LinearGradient cardOverlay = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1AA78BFA), Color(0x0D38BDF8)],
  );

  static Color typeBadgeBg(String type) {
    return _typeColors[type.toLowerCase()]?.$1 ?? const Color(0x3338BDF8);
  }

  static Color typeBadgeFg(String type) {
    return _typeColors[type.toLowerCase()]?.$2 ?? accentBlue;
  }

  static Color typeBadgeBorder(String type) {
    return _typeColors[type.toLowerCase()]?.$3 ?? const Color(0x6638BDF8);
  }

  static const Map<String, (Color, Color, Color)> _typeColors = {
    'eau': (Color(0x3338BDF8), Color(0xFF38BDF8), Color(0x6638BDF8)),
    'feu': (Color(0x33F97316), Color(0xFFF97316), Color(0x66F97316)),
    'plante': (Color(0x334ADE80), Color(0xFF4ADE80), Color(0x664ADE80)),
    'électrik': (Color(0x33FACC15), Color(0xFFFACC15), Color(0x66FACC15)),
    'psy': (Color(0x33F472B6), Color(0xFFF472B6), Color(0x66F472B6)),
    'glace': (Color(0x3367E8F0), Color(0xFF67E8F0), Color(0x6667E8F0)),
    'combat': (Color(0x33FB923C), Color(0xFFFB923C), Color(0x66FB923C)),
    'poison': (Color(0x33C084FC), Color(0xFFC084FC), Color(0x66C084FC)),
    'sol': (Color(0x33D97706), Color(0xFFD97706), Color(0x66D97706)),
    'vol': (Color(0x3393C5FD), Color(0xFF93C5FD), Color(0x6693C5FD)),
    'insecte': (Color(0x3384CC14), Color(0xFF84CC14), Color(0x6684CC14)),
    'roche': (Color(0x33A8A29E), Color(0xFFA8A29E), Color(0x66A8A29E)),
    'spectre': (Color(0x338B5CF6), Color(0xFF8B5CF6), Color(0x668B5CF6)),
    'dragon': (Color(0x336366F1), Color(0xFF6366F1), Color(0x666366F1)),
    'ténèbres': (Color(0x3371717A), Color(0xFF71717A), Color(0x6671717A)),
    'acier': (Color(0x33CBD5E1), Color(0xFFCBD5E1), Color(0x66CBD5E1)),
    'normal': (Color(0x33D4D4D8), Color(0xFFD4D4D8), Color(0x66D4D4D8)),
    'fée': (Color(0x33F9A8D4), Color(0xFFF9A8D4), Color(0x66F9A8D4)),
  };

  static Color statColor(int value) {
    if (value >= 100) return accentBlue;
    if (value >= 70) return accentPurple;
    if (value >= 50) return const Color(0xFF818CF8);
    return const Color(0xFF6366F1);
  }

  static BoxDecoration get pageDecoration => const BoxDecoration(color: pageBg);

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardBg,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: cardBorder),
    gradient: cardOverlay,
  );

  static BoxDecoration get headerDecoration => const BoxDecoration(
    color: headerBg,
    border: Border(bottom: BorderSide(color: headerBorder)),
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle pokemonNameStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: textPrimary,
  );

  static const TextStyle sectionLabelStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: textMuted,
    letterSpacing: 1.2,
  );

  static const TextStyle statValueStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );
}
