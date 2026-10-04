import 'package:flutter/material.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

/// Pastille de type, pensée pour être posée sur un fond de la couleur du type
/// (carte ou en-tête de la fiche) : fond translucide, texte lisible.
class StyledType extends StatelessWidget {
  const StyledType({super.key, required this.type, this.fontSize = 12});

  final String type;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final onColor = PokedexTheme.onTypeColor(type);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: onColor.withValues(alpha: 0.2),
        border: Border.all(color: onColor.withValues(alpha: 0.45)),
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: fontSize * 0.85),
      child: Text(
        type,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: onColor,
        ),
      ),
    );
  }
}
