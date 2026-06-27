import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';
import 'package:pokemon_client/src/features/pokemon/domain/stats.dart';

class Pokemon {
  Pokemon({
    required this.pokedexId,
    required this.name,
    required this.types,
    required this.sprites,
    this.category = "",
    this.stats,
    this.height = "",
    this.weight = "",
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemon = Pokemon(
      pokedexId: json['pokedex_id'] ?? 0,
      name: json['name']['fr'] ?? "",
      sprites: Sprite.fromJson(json['sprites']),
      types: (json['types'] as List)
          .cast<Map<String, dynamic>>()
          .map((t) => PokemonType.fromJson(t))
          .toList(),
      category: json['category'] ?? "",
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
      height: json['height'] ?? "",
      weight: json['weight'] ?? "",
    );

    if (json['isFav'] == true) {
      pokemon.toggleIsFav();
    }

    return pokemon;
  }

  final int pokedexId;
  final String name;
  final Sprite sprites;
  final List<PokemonType> types;
  final String category;
  final Stats? stats;
  final String height;
  final String weight;
  bool _isFav = false;

  bool get isFav => _isFav;

  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
