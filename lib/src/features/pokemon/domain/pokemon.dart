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
