import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_client/src/common_widgets/styled_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/routes/app_router.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        AppRoute.detail.name,
        pathParameters: {'id': pokemon.pokedexId.toString()},
      ),
      child: Container(
        decoration: DarkGlass.cardDecoration,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: DarkGlass.cardOverlay,
                ),
              ),
            ),

            Positioned(
              top: 8,
              right: 12,
              child: Text(
                '#${pokemon.pokedexId.toString().padLeft(3, '0')}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: DarkGlass.textFaint,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white70],
                ).createShader(rect),
                blendMode: BlendMode.modulate,
                child: Image.network(
                  pokemon.sprites.regular,
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                left: 14,
                bottom: 12,
                right: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pokemon.name, style: DarkGlass.pokemonNameStyle),
                  const SizedBox(height: 8),
                  for (final t in pokemon.types) ...[
                    SizedBox(width: 110, child: StyledType(type: t.name)),
                    const SizedBox(height: 4),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
