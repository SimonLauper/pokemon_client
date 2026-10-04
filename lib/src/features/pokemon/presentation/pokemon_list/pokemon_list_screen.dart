import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/common_widgets/pokedex_header.dart';
import 'package:pokemon_client/src/common_widgets/pokeball.dart';
import 'package:pokemon_client/src/common_widgets/status_views.dart';
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
    _scrollController.addListener(_loadMoreIfNeeded);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreIfNeeded() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: PokedexTheme.screenBg,
        body: Column(
          children: [
            PokedexHeader(child: _buildTypeFilter()),
            Expanded(
              child: pokemonAsync.when(
                loading: () => const LoadingView(),
                error: (e, _) => ErrorView(
                  error: e,
                  onRetry: () =>
                      ref.read(pokemonProvider.notifier).fetchPokemons(),
                ),
                data: _buildGrid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(PokemonState state) {
    if (state.pokemons.isEmpty) return const EmptyView();

    final hasMore = state.currentPage < state.totalPages;
    if (hasMore) {
      // Sur grand écran, la première page peut ne pas remplir la fenêtre :
      // aucun scroll ne serait alors possible pour déclencher la suite.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadMoreIfNeeded();
      });
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisExtent: 134,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => PokemonCard(pokemon: state.pokemons[index]),
              childCount: state.pokemons.length,
            ),
          ),
        ),
        if (hasMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: PokeballLoader(size: 32)),
            ),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ),
      ],
    );
  }

  Widget _buildTypeFilter() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedType,
      isExpanded: true,
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Pokeball(size: 22),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: PokedexTheme.ledYellow, width: 2),
        ),
      ),
      hint: const Text(
        'Tous les types',
        style: TextStyle(color: PokedexTheme.inkMuted, fontSize: 14),
      ),
      icon: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.keyboard_arrow_down_rounded, color: PokedexTheme.red),
      ),
      dropdownColor: Colors.white,
      style: const TextStyle(
        color: PokedexTheme.ink,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('Tous les types'),
        ),
        ..._typesList.map(
          (type) => DropdownMenuItem<String>(
            value: type,
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PokedexTheme.typeColor(type),
                  ),
                ),
                const SizedBox(width: 10),
                Text(type),
              ],
            ),
          ),
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
    );
  }
}
