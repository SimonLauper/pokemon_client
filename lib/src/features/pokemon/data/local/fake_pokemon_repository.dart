import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/constants/test_pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';

class FakePokemonRepository {
  List<Pokemon> getAllPokemons() {
    return testPokemon;
  }

  Pokemon getPokemonById(String pokemonId) {
    return testPokemon.firstWhere(
      (pokemon) => pokemon.pokedexId == int.parse(pokemonId),
    );
  }

  List<Pokemon> getPokemonByType(String? type) {
    return testPokemon
        .where((pokemon) => pokemon.types.any((t) => t.name == type))
        .toList();
  }
}

final pokemonRepositoryProvider = FutureProvider((ref) {
  return FakePokemonRepository();
});
