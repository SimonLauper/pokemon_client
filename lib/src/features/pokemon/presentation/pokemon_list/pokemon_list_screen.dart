import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/data/remote/pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_card.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedType;

  final _typesList = const [
    'Acier',
    'Combat',
    'Dragon',
    'Eau',
    'Électrik',
    'Fée',
    'Feu',
    'Glace',
    'Insecte',
    'Normal',
    'Plante',
    'Poison',
    'Psy',
    'Roche',
    'Sol',
    'Spectre',
    'Ténèbres',
    'Vol',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(pokemonProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonAsync = kIsWeb
        ? ref.watch(pokemonProvider)
        : AsyncData(
            PokemonState(
              pokemons: _selectedType == null
                  ? FakePokemonRepository().getAllPokemons()
                  : FakePokemonRepository().getPokemonByType(_selectedType),
              currentPage: 1,
              totalPages: 1,
            ),
          );

    return Scaffold(
      backgroundColor: DarkGlass.pageBg,
      body: Stack(
        children: [
          Positioned(
            right: -100,
            top: -60,
            child: Opacity(
              opacity: 0.06,
              child: Image.asset('assets/img/Pokeball.png', width: 320),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildTypeFilter(),
                Expanded(
                  child: pokemonAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: DarkGlass.accentPurple,
                      ),
                    ),
                    error: (e, _) => Center(
                      child: Text(
                        'Erreur : $e',
                        style: const TextStyle(color: DarkGlass.textPrimary),
                      ),
                    ),
                    data: (state) => GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 20),
                      itemCount: state.pokemons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemBuilder: (context, index) =>
                          PokemonCard(pokemon: state.pokemons[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: DarkGlass.headerDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) =>
              DarkGlass.accentGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: const Text('Pokédex', style: DarkGlass.titleStyle),
        ),
      ),
    );
  }

  Widget _buildTypeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Theme(
        // Override du thème Flutter pour que le dropdown soit dark
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF1E1E35)),
        child: DropdownButtonFormField<String>(
          value: _selectedType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            filled: true,
            fillColor: DarkGlass.cardBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: DarkGlass.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: DarkGlass.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: DarkGlass.accentPurple,
                width: 1.5,
              ),
            ),
          ),
          hint: const Text(
            'Tous les types',
            style: TextStyle(color: DarkGlass.textMuted, fontSize: 14),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: DarkGlass.accentPurple,
          ),
          dropdownColor: const Color(0xFF1E1E35),
          style: const TextStyle(
            color: DarkGlass.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          items: [
            // Option "Tous"
            const DropdownMenuItem<String>(
              value: null,
              child: Text('Tous les types'),
            ),
            ..._typesList.map(
              (type) =>
                  DropdownMenuItem<String>(value: type, child: Text(type)),
            ),
          ],
          onChanged: (value) {
            setState(() => _selectedType = value);
            if (value == null) {
              ref.read(pokemonProvider.notifier).fetchPokemons();
            } else {
              ref.read(pokemonProvider.notifier).getPokemonByType(value);
            }
          },
        ),
      ),
    );
  }
}
