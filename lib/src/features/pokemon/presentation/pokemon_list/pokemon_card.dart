import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_client/src/common_widgets/pokeball.dart';
import 'package:pokemon_client/src/common_widgets/styled_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/routes/app_router.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final mainType = pokemon.types.isEmpty ? 'normal' : pokemon.types.first.name;
    final onColor = PokedexTheme.onTypeColor(mainType);
    final radius = BorderRadius.circular(22);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: PokedexTheme.typeColor(mainType).withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: PokedexTheme.typeGradient(mainType),
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: () => context.goNamed(
              AppRoute.detail.name,
              pathParameters: {'id': pokemon.pokedexId.toString()},
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: Stack(
                children: [
                  Positioned(
                    right: -22,
                    bottom: -22,
                    child: Pokeball.silhouette(
                      size: 120,
                      color: onColor.withValues(alpha: 0.16),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Image.network(
                      pokemon.sprites.regular,
                      width: 82,
                      height: 82,
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                      errorBuilder: (_, _, _) =>
                          const SizedBox(width: 82, height: 82),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                pokemon.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: PokedexTheme.pokemonNameStyle.copyWith(
                                  color: onColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '#${pokemon.pokedexId.toString().padLeft(3, '0')}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: onColor.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        for (final t in pokemon.types) ...[
                          StyledType(type: t.name),
                          const SizedBox(height: 4),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
