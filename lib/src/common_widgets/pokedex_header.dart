import 'package:flutter/material.dart';
import 'package:pokemon_client/src/common_widgets/pokeball.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

/// En-tête façon Pokédex : coque rouge, lentille bleue et trois voyants.
/// [child] est affiché sous le titre (ici : le filtre par type).
class PokedexHeader extends StatelessWidget {
  const PokedexHeader({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: PokedexTheme.shellGradient,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: PokedexTheme.redDark.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -50,
              child: Pokeball.silhouette(
                size: 190,
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const _Lens(),
                        const SizedBox(width: 12),
                        const _Leds(),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pokédex',
                                style: PokedexTheme.titleStyle,
                              ),
                              Text(
                                'Attrapez-les tous !',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (child != null) ...[const SizedBox(height: 14), child!],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Lens extends StatelessWidget {
  const _Lens();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF083B85), width: 2),
          gradient: const RadialGradient(
            center: Alignment(-0.35, -0.35),
            colors: [Color(0xFF9BDBFF), PokedexTheme.lensBlue, PokedexTheme.lensBlueDark],
            stops: [0, 0.45, 1],
          ),
        ),
        child: Align(
          alignment: const Alignment(-0.4, -0.45),
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ),
      ),
    );
  }
}

class _Leds extends StatelessWidget {
  const _Leds();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Led(PokedexTheme.ledRed),
        SizedBox(width: 6),
        _Led(PokedexTheme.ledYellow),
        SizedBox(width: 6),
        _Led(PokedexTheme.ledGreen),
      ],
    );
  }
}

class _Led extends StatelessWidget {
  const _Led(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.7), blurRadius: 6),
        ],
      ),
    );
  }
}
