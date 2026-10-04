import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_client/src/common_widgets/pokeball.dart';
import 'package:pokemon_client/src/common_widgets/status_views.dart';
import 'package:pokemon_client/src/common_widgets/styled_type.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/data/remote/pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/stats.dart';
import 'package:pokemon_client/src/routes/app_router.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

/// Hauteur du sprite et part de celui-ci qui déborde sur l'en-tête coloré.
const double _spriteSize = 210;
const double _spriteOverlap = 112;

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

    return pokemonAsync.when(
      loading: () => _buildPlaceholder(const LoadingView()),
      error: (e, _) => _buildPlaceholder(
        ErrorView(
          error: e,
          onRetry: () =>
              ref.invalidate(getPokemonByIdProvider(widget.pokedexId)),
        ),
      ),
      data: _buildContent,
    );
  }

  void _goBack() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.goNamed(AppRoute.home.name);
    }
  }

  Widget _buildPlaceholder(Widget child) {
    return Scaffold(
      backgroundColor: PokedexTheme.screenBg,
      body: Stack(
        children: [
          child,
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _RoundButton(
                color: PokedexTheme.red,
                onTap: _goBack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(Pokemon pokemon) {
    final mainType = pokemon.types.isEmpty ? 'normal' : pokemon.types.first.name;
    final onColor = PokedexTheme.onTypeColor(mainType);
    final accent = PokedexTheme.typeColorDark(mainType, 0.18);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: onColor == Colors.white
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: PokedexTheme.typeColor(mainType),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: PokedexTheme.typeGradient(mainType),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -50,
                right: -80,
                child: Pokeball.silhouette(
                  size: 320,
                  color: onColor.withValues(alpha: 0.14),
                ),
              ),
              Column(
                children: [
                  SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        _buildTopBar(pokemon, onColor),
                        const SizedBox(height: 4),
                        _buildTitle(pokemon, onColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: _spriteOverlap),
                  Expanded(child: _buildSheet(pokemon, accent)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Pokemon pokemon, Color onColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
      child: Row(
        children: [
          _RoundButton(color: onColor, onTap: _goBack),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: onColor.withValues(alpha: 0.18),
            ),
            child: Text(
              'N°${pokemon.pokedexId}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: onColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(Pokemon pokemon, Color onColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            pokemon.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: onColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final t in pokemon.types)
                StyledType(type: t.name, fontSize: 13),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSheet(Pokemon pokemon, Color accent) {
    final stats = pokemon.stats;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: PokedexTheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              _spriteSize - _spriteOverlap + 12,
              20,
              MediaQuery.of(context).padding.bottom + 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle('À PROPOS', accent: accent),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.catching_pokemon,
                        label: 'CATÉGORIE',
                        value: pokemon.category,
                        accent: accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.monitor_weight_outlined,
                        label: 'POIDS',
                        value: pokemon.weight,
                        accent: accent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.straighten_rounded,
                        label: 'TAILLE',
                        value: pokemon.height,
                        accent: accent,
                      ),
                    ),
                  ],
                ),
                if (stats != null) ...[
                  const SizedBox(height: 28),
                  _SectionTitle('STATISTIQUES DE BASE', accent: accent),
                  const SizedBox(height: 14),
                  _buildStats(stats),
                ],
              ],
            ),
          ),
        ),
        Positioned(
          top: -_spriteOverlap,
          left: 0,
          right: 0,
          height: _spriteSize,
          child: Center(
            child: Image.network(
              pokemon.sprites.regular,
              height: _spriteSize,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) => Pokeball.silhouette(
                size: 120,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(Stats stats) {
    return Column(
      children: [
        _StatRow(label: 'HP', value: stats.hp, maxVal: 255),
        _StatRow(label: 'Attaque', value: stats.atk, maxVal: 185),
        _StatRow(label: 'Défense', value: stats.def, maxVal: 230),
        _StatRow(label: 'Atq. Spé.', value: stats.speAtk, maxVal: 194),
        _StatRow(label: 'Déf. Spé.', value: stats.speDef, maxVal: 230),
        _StatRow(label: 'Vitesse', value: stats.vit, maxVal: 200),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {required this.accent});

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: PokedexTheme.sectionLabelStyle),
      ],
    );
  }
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 78,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: PokedexTheme.inkMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 38,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: PokedexTheme.ink,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 9,
                color: PokedexTheme.screenBg,
                alignment: Alignment.centerLeft,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: ratio),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, factor, _) => FractionallySizedBox(
                    widthFactor: factor,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: PokedexTheme.statColor(value),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
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
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: PokedexTheme.screenBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PokedexTheme.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: accent),
          const SizedBox(height: 6),
          Text(
            value.isEmpty ? '—' : value,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: PokedexTheme.ink,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: PokedexTheme.sectionLabelStyle.copyWith(
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.18),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(Icons.arrow_back_ios_new_rounded, color: color, size: 18),
        ),
      ),
    );
  }
}
