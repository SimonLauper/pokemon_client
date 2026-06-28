import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/data/remote/pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_details/heart.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class PokemonDetailsScreen extends ConsumerStatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokedexId});

  final String pokedexId;

  @override
  ConsumerState<PokemonDetailsScreen> createState() =>
      _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends ConsumerState<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonAsync = kIsWeb
        ? ref.watch(getPokemonByIdProvider(widget.pokedexId))
        : AsyncData(FakePokemonRepository().getPokemonById(widget.pokedexId));

    return Scaffold(
      backgroundColor: DarkGlass.pageBg,
      body: pokemonAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: DarkGlass.accentPurple),
        ),
        error: (e, _) => Center(
          child: Text(
            'Erreur : $e',
            style: const TextStyle(color: DarkGlass.textPrimary),
          ),
        ),
        data: (pokemon) => Column(
          children: [
            _buildHero(pokemon),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF111122),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameRow(pokemon),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildStats(pokemon)),
                          const SizedBox(width: 20),
                          _buildInfoPanel(pokemon),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(dynamic pokemon) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, 0.4),
                  radius: 0.7,
                  colors: [
                    DarkGlass.accentBlue.withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: Image.network(
              pokemon.sprites.regular,
              height: 220,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: _GlassButton(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: DarkGlass.accentPurple,
                size: 16,
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 14,
            right: 18,
            child: Text(
              'N°${pokemon.pokedexId}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: DarkGlass.textFaint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameRow(dynamic pokemon) {
    return Row(
      children: [
        Expanded(
          child: Text(
            pokemon.name,
            style: DarkGlass.pokemonNameStyle.copyWith(fontSize: 26),
          ),
        ),
        Heart(
          isFav: pokemon.isFav,
          onToggle: () async {
            if (kIsWeb) {
              await ref
                  .read(pokemonProvider.notifier)
                  .setPokemonToFav(pokemon.pokedexId);
              ref.invalidate(getPokemonByIdProvider(widget.pokedexId));
            } else {
              pokemon.toggleIsFav();
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _buildStats(dynamic pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('STATS'),
        const SizedBox(height: 10),
        _StatRow(label: 'HP', value: pokemon.stats!.hp, maxVal: 255),
        _StatRow(label: 'Attaque', value: pokemon.stats!.atk, maxVal: 185),
        _StatRow(label: 'Défense', value: pokemon.stats!.def, maxVal: 230),
        _StatRow(label: 'Sp. Atk', value: pokemon.stats!.speAtk, maxVal: 194),
        _StatRow(label: 'Sp. Def', value: pokemon.stats!.speDef, maxVal: 230),
        _StatRow(label: 'Vitesse', value: pokemon.stats!.vit, maxVal: 200),
      ],
    );
  }

  Widget _buildInfoPanel(dynamic pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _sectionLabel('TYPE'),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          height: 44,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 44,
            ),
            itemCount: pokemon.types.length,
            itemBuilder: (context, i) => Image.network(pokemon.types[i].image),
          ),
        ),
        const SizedBox(height: 12),
        _InfoTile(label: 'CATÉGORIE', value: pokemon.category),
        const SizedBox(height: 8),
        _InfoTile(label: 'POIDS', value: pokemon.weight),
        const SizedBox(height: 8),
        _InfoTile(label: 'TAILLE', value: pokemon.height),
      ],
    );
  }

  Widget _sectionLabel(String text) => Text(
    text,
    style: DarkGlass.sectionLabelStyle.copyWith(
      color: DarkGlass.accentPurple,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),
  );
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.maxVal,
  });

  final String label;
  final int value;
  final double maxVal;

  @override
  Widget build(BuildContext context) {
    final ratio = (value / maxVal).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: DarkGlass.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 26,
            child: Text(
              value.toString(),
              style: DarkGlass.statValueStyle.copyWith(fontSize: 11),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 5,
                backgroundColor: Colors.white.withOpacity(0.08),
                valueColor: AlwaysStoppedAnimation<Color>(
                  DarkGlass.statColor(value),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: DarkGlass.infoTileBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: DarkGlass.cardBorder),
      ),
      child: Column(
        children: [
          Text(label, style: DarkGlass.sectionLabelStyle),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: DarkGlass.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.08),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Center(child: child),
      ),
    );
  }
}
