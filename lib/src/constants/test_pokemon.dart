import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';

final testPokemon = [
  Pokemon(
    pokedexId: 1,
    name: "Bulbizarre",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/shiny.png',
    ),

    types: [
      PokemonType(name: "Plante", image: ""),
      PokemonType(name: "Poison", image: ""),
    ],
  ),
  Pokemon(
    pokedexId: 2,
    name: "Herbizarre",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/shiny.png',
    ),
    types: [
      PokemonType(name: "Plante", image: ""),
      PokemonType(name: "Poison", image: ""),
    ],
  ),
  Pokemon(
    pokedexId: 3,
    name: "Florizarre",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/shiny.png',
    ),

    types: [
      PokemonType(name: "Plante", image: ""),
      PokemonType(name: "Poison", image: ""),
    ],
  ),
];
