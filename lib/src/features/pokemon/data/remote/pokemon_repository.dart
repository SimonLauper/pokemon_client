import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';

class PokemonState {
  final List<Pokemon> pokemons;
  final int currentPage;
  final int totalPages;
  final String filter;

  const PokemonState({
    this.pokemons = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.filter = '',
  });

  PokemonState copyWith({
    List<Pokemon>? pokemons,
    int? currentPage,
    int? totalPages,
    String? filter,
  }) {
    return PokemonState(
      pokemons: pokemons ?? this.pokemons,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      filter: filter ?? this.filter,
    );
  }
}

class PokemonNotifier extends AsyncNotifier<PokemonState> {
  static const _url = 'https://api.lauper-dev.ch';

  @override
  Future<PokemonState> build() async {
    return await _fetchPage1();
  }

  bool _isLoading = false;

  Future<PokemonState> _fetchPage1() async {
    final response = await http.get(Uri.parse('$_url/pokemons?page=1'));
    if (response.statusCode != 200) {
      throw FormatException('Failed to load pokemons');
    }
    final data = jsonDecode(response.body);
    final pokemons = (data['pokemons'] as List)
        .map((json) => Pokemon.fromJson(json))
        .toList();
    return PokemonState(
      pokemons: pokemons,
      currentPage: data['currentPage'],
      totalPages: data['totalPages'],
      filter: '',
    );
  }

  Future<void> fetchPokemons() async {
    if (_isLoading) return;
    _isLoading = true;
    state = const AsyncLoading();
    try {
      state = AsyncData(await _fetchPage1());
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      _isLoading = false;
    }
  }

  void loadMore() async {
    if (_isLoading) return;
    final current = state.value;
    if (current == null || current.currentPage >= current.totalPages) return;

    _isLoading = true;
    try {
      final nextPage = current.currentPage + 1;
      final type = current.filter;

      final response = type.isNotEmpty
          ? await http.get(
              Uri.parse(
                '$_url/pokemons/type?type=$type&page=$nextPage&limit=20',
              ),
            )
          : await http.get(Uri.parse('$_url/pokemons?page=$nextPage&limit=20'));

      if (response.statusCode != 200) {
        throw FormatException('Failed to load more pokemons');
      }

      final data = jsonDecode(response.body);
      final newPokemons = (data['pokemons'] as List)
          .map((json) => Pokemon.fromJson(json))
          .toList();

      state = AsyncData(
        current.copyWith(
          pokemons: [...current.pokemons, ...newPokemons],
          currentPage: data['currentPage'],
          totalPages: data['totalPages'],
        ),
      );
    } catch (e) {
    } finally {
      _isLoading = false;
    }
  }

  void getPokemonByType(String type) async {
    if (_isLoading) return;
    _isLoading = true;
    state = const AsyncLoading();
    try {
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
      state = AsyncData(
        PokemonState(
          pokemons: pokemons,
          currentPage: data['currentPage'],
          totalPages: data['totalPages'],
          filter: type,
        ),
      );
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      _isLoading = false;
    }
  }

  Future<Pokemon> getPokemonById(String id) async {
    final parsedId = int.tryParse(id);
    final response = await http.get(Uri.parse('$_url/pokemons/$parsedId'));
    if (response.statusCode != 200) {
      throw FormatException('Une erreur est survenue');
    }
    return Pokemon.fromJson(jsonDecode(response.body));
  }

  Future<void> setPokemonToFav(int id) async {
    final response = await http.patch(Uri.parse('$_url/pokemons/$id'));
    if (response.statusCode != 200) {
      throw FormatException('Failed to set or unset pokemon as fav');
    }
  }
}

final getPokemonByIdProvider = FutureProvider.family<Pokemon, String>((
  ref,
  pokedexId,
) {
  return ref.watch(pokemonProvider.notifier).getPokemonById(pokedexId);
});

final pokemonProvider = AsyncNotifierProvider<PokemonNotifier, PokemonState>(
  () => PokemonNotifier(),
);
