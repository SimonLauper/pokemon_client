import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/constants/test_pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';

class FakePokemonRepository {
  List<Pokemon> getAllPokemons() {
    return testPokemon;
  }
}

final pokemonRepositoryProvider = Provider((ref) {
  return FakePokemonRepository();
});
