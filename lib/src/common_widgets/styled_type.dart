import 'package:flutter/material.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class StyledType extends StatelessWidget {
  const StyledType({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: DarkGlass.typeBadgeBg(type),
        border: Border.all(color: DarkGlass.typeBadgeBorder(type), width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Center(
        child: Text(
          type,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: DarkGlass.typeBadgeFg(type),
          ),
        ),
      ),
    );
  }
}
