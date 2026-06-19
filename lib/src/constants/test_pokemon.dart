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
  Pokemon(
    pokedexId: 4,
    category: "Pokémon Lézard",
    name: "Salamèche",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/4/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/4/shiny.png',
    ),
    types: [
      PokemonType(
        name: "Feu",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/feu.png",
      ),
    ],
    stats: Stats(hp: 39, atk: 52, def: 43, speAtk: 60, speDef: 50, vit: 65),
    height: "0,6 m",
    weight: "8,5 kg",
  ),
  Pokemon(
    pokedexId: 5,
    category: "Pokémon Flamme",
    name: "Reptincel",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/5/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/5/shiny.png',
    ),
    types: [
      PokemonType(
        name: "Feu",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/feu.png",
      ),
    ],
    stats: Stats(hp: 58, atk: 64, def: 58, speAtk: 80, speDef: 65, vit: 80),
    height: "1,1 m",
    weight: "19,0 kg",
  ),
  Pokemon(
    pokedexId: 6,
    category: "Pokémon Flamme",
    name: "Dracaufeu",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/6/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/6/shiny.png',
    ),
    types: [
      PokemonType(
        name: "Feu",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/feu.png",
      ),
      PokemonType(
        name: "Vol",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/vol.png",
      ),
    ],
    stats: Stats(hp: 78, atk: 84, def: 78, speAtk: 109, speDef: 85, vit: 100),
    height: "1,7 m",
    weight: "90,5 kg",
  ),
  Pokemon(
    pokedexId: 7,
    category: "Pokémon Minitortue",
    name: "Carapuce",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/7/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/7/shiny.png',
    ),
    types: [
      PokemonType(
        name: "Eau",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/eau.png",
      ),
    ],
    stats: Stats(hp: 44, atk: 48, def: 65, speAtk: 50, speDef: 64, vit: 43),
    height: "0,5 m",
    weight: "9,0 kg",
  ),
  Pokemon(
    pokedexId: 8,
    category: "Pokémon Tortue",
    name: "Carabaffe",
    sprites: Sprite(
      regular:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/8/regular.png',
      shiny:
          'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/8/shiny.png',
    ),
    types: [
      PokemonType(
        name: "Eau",
        image:
            "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/eau.png",
      ),
    ],
    stats: Stats(hp: 59, atk: 63, def: 80, speAtk: 65, speDef: 80, vit: 58),
    height: "1,0 m",
    weight: "22,5 kg",
  ),
];
