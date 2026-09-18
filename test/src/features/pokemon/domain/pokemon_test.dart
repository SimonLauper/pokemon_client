import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';
import 'package:pokemon_client/src/features/pokemon/domain/stats.dart';

void main() {
  group('tests pokemon class', () {
    late Pokemon pokemon;
    setUp(() {
      pokemon = Pokemon(
        pokedexId: 1,
        category: "Pokemon Graine",
        name: "Bulbizarre",
        sprites: Sprite(
          regular:
              'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png',
          shiny:
              'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/shiny.png',
        ),

        types: [
          PokemonType(
            name: "Plante",
            image:
                "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/plante.png",
          ),
          PokemonType(
            name: "Poison",
            image:
                "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/poison.png",
          ),
        ],
        stats: Stats(hp: 45, atk: 45, def: 45, speAtk: 30, speDef: 60, vit: 30),
        height: "0.7 m",
        weight: "6.9 kg",
      );
      return pokemon;
    });

    test('exposes the fields it was constructed with', () {
      expect(pokemon.pokedexId, 1);
      expect(pokemon.name, "Bulbizarre");
    });
  });
}
