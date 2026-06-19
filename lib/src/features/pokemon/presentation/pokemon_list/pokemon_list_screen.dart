import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_card.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemons = ref.read(pokemonRepositoryProvider).getAllPokemons();
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
