import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/local/fake_pokemon_repository.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_details/heart.dart';

class PokemonDetailsScreen extends ConsumerStatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokedexId});

  final String pokedexId;

  @override
  ConsumerState<PokemonDetailsScreen> createState() =>
      _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends ConsumerState<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemon = ref
        .read(pokemonRepositoryProvider)
        .getPokemonById(widget.pokedexId);
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Image.network(pokemon.sprites.regular)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                    ),
                    border: Border.all(width: 4, color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 36,
                              ),
                              child: Text(
                                pokemon.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Heart(pokemon: pokemon)),
                          Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("N°${pokemon.pokedexId}"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "STATS",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text("HP"),
                                      SizedBox(height: 4),
                                      Text("Attack"),
                                      SizedBox(height: 4),
                                      Text("Defense"),
                                      SizedBox(height: 4),
                                      Text("Sp. Atk"),
                                      SizedBox(height: 4),
                                      Text("Sp. Def"),
                                      SizedBox(height: 4),
                                      Text("Speed"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.hp.toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.hp / 255,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.atk.toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.atk / 185,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.def.toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.def / 230,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.speAtk
                                                    .toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.speAtk /
                                                      194,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.speDef
                                                    .toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.speDef /
                                                      230,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                              child: Text(
                                                pokemon.stats!.vit.toString(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 10,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      pokemon.stats!.vit / 200,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.green),
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "TYPE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: SizedBox(
                                    width: 100,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisExtent: 40,
                                          ),
                                      itemCount: pokemon.types.length,
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          pokemon.types[index].image,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "CATEGORY",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(pokemon.category),
                                SizedBox(height: 8),
                                Text(
                                  "WEIGHT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(pokemon.weight),
                                SizedBox(height: 8),
                                Text(
                                  "HEIGHT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(pokemon.height),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
