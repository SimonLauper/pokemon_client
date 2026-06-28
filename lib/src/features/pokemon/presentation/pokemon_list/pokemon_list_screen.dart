import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/remote/pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_card.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();

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

  String? _selectedType;

  final typesList = [
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
  Widget build(BuildContext context) {
    final pokemonAsync = ref.watch(pokemonProvider);

    return Stack(
      children: [
        Positioned(
          right: -152,
          top: -75,
          child: Image.asset('assets/img/Pokeball.png', width: 400),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Pokedex"),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: DropdownButton<String>(
                  value: _selectedType,
                  hint: const Icon(Icons.filter_alt),
                  items: typesList.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                    if (value == null) {
                      ref.read(pokemonProvider.notifier).fetchPokemons();
                    } else {
                      ref
                          .read(pokemonProvider.notifier)
                          .getPokemonByType(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: pokemonAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Erreur : $error')),
                  data: (state) => Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 8,
                      right: 8,
                      bottom: 8,
                    ),
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: state.pokemons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150,
                          ),
                      itemBuilder: (context, index) {
                        return PokemonCard(pokemon: state.pokemons[index]);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
