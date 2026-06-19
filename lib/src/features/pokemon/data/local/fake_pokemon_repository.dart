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
}

final pokemonRepositoryProvider = Provider((ref) {
  return FakePokemonRepository();
});
