import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_card.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
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
    final repository = ref.read(pokemonRepositoryProvider);
    final List<Pokemon> pokemons = _selectedType == null
        ? repository.getAllPokemons()
        : repository.getPokemonByType(_selectedType);

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
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: GridView.builder(
                    itemCount: pokemons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 150,
                        ),
                    itemBuilder: (context, index) {
                      return PokemonCard(pokemon: pokemons[index]);
                    },
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
