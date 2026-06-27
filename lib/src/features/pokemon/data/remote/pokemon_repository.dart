import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';

class PokemonState {
  final List<Pokemon> pokemons;
  final String filter;

  const PokemonState({this.pokemons = const [], this.filter = ''});

  PokemonState copyWith({List<Pokemon>? pokemons, String? filter}) {
    return PokemonState(
      pokemons: pokemons ?? this.pokemons,
      filter: filter ?? this.filter,
    );
  }
}

class PokemonNotifier extends AsyncNotifier<PokemonState> {
  static const _url = 'http://localhost:3000';

  @override
  Future<PokemonState> build() async {
    return await fetchPokemons();
  }

  bool _isLoading = false;
  Future<PokemonState> fetchPokemons() async {
    try {
      final response = await http.get(Uri.parse('$_url/pokemons?page=1'));

      if (response.statusCode != 200) {
        throw FormatException('Failed to load pokemons');
      }

      final data = jsonDecode(response.body);

      final pokemons = (data['pokemons'] as List)
          .map((json) => Pokemon.fromJson(json))
          .toList();

      return PokemonState(pokemons: pokemons);
    } catch (e) {
      rethrow;
    }
  }

  void getPokemonByType(String? type) async {
    if (_isLoading) return;
    _isLoading = true;
    state = AsyncLoading();
    try {
      final current = state.value;
      if (current == null) return;

      final response = await http.get(
        Uri.parse('$_url/pokemons/type?type=$type&page=1'),
      );
      if (response.statusCode != 200) {
        throw FormatException('Une erreur est survenue');
      }

      final data = jsonDecode(response.body);
      final pokemons = (data['pokemons'] as List)
          .map((json) => Pokemon.fromJson(json))
          .toList();
      state = AsyncData(current.copyWith(pokemons: pokemons, filter: type));
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      rethrow;
    }
  }

  Future<Pokemon> getPokemonById(String id) async {
    final parsedId = int.tryParse(id);
    try {
      final response = await http.get(Uri.parse('$_url/pokemons/$parsedId'));
      if (response.statusCode != 200) {
        throw FormatException('Une erreur est survenue');
      }

      final json = jsonDecode(response.body);
      final pokemon = Pokemon.fromJson(json);
      return pokemon;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setPokemonToFav(int id) async {
    try {
      final response = await http.patch(Uri.parse('$_url/pokemons/$id'));
      if (response.statusCode != 200) {
        throw FormatException('Failed to set or unset pokemon as fav');
      }
    } catch (e) {
      rethrow;
    }
  }
}

final getPokemonByIdProvider = FutureProvider.family<Pokemon, String>((
  ref,
  pokedexId,
) {
  final notifier = ref.watch(pokemonProvider.notifier);
  return notifier.getPokemonById(pokedexId);
});

final pokemonProvider = AsyncNotifierProvider<PokemonNotifier, PokemonState>(
  () => PokemonNotifier(),
);
