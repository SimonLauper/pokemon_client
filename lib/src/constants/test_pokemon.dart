import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';
import 'package:pokemon_client/src/features/pokemon/domain/stats.dart';

final testPokemon = [
  Pokemon(
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
  ),
  Pokemon(
    pokedexId: 2,
    category: "Pokemon Graine",
    name: "Herbizarre",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/shiny.png',
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
    height: "1.0",
    weight: "13.0",
  ),
  Pokemon(
    pokedexId: 3,
    category: "Pokemon Graine",
    name: "Florizarre",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/shiny.png',
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
    height: "2.0",
    weight: "100.0",
  ),
];
