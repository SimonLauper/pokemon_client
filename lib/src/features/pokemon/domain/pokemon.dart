import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';

class Pokemon {
  Pokemon({
    required this.pokedexId,
    required this.name,
    required this.types,
    required this.sprites,
  });

  final int pokedexId;
  final String name;
  final Sprite sprites;
  final List<PokemonType> types;
}
