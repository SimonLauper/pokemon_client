import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_client/src/features/pokemon/data/remote/pokemon_repository.dart';
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
    final pokemonAsync = ref.watch(getPokemonByIdProvider(widget.pokedexId));

    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: pokemonAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (pokemon) => Stack(
          children: [
            Column(
              children: [
                Expanded(child: Image.network(pokemon.sprites.regular)),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                      ),
                      border: Border.all(width: 4, color: Colors.green),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
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
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Heart(
                                  isFav: pokemon.isFav,
                                  onToggle: () async {
                                    await ref
                                        .read(pokemonProvider.notifier)
                                        .setPokemonToFav(pokemon.pokedexId);
                                    ref.invalidate(
                                      getPokemonByIdProvider(widget.pokedexId),
                                    );
                                  },
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text("N°${pokemon.pokedexId}"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            const SizedBox(height: 30),
                                            _buildStatRow(
                                              pokemon.stats!.hp,
                                              255,
                                            ),
                                            const SizedBox(height: 4),
                                            _buildStatRow(
                                              pokemon.stats!.atk,
                                              185,
                                            ),
                                            const SizedBox(height: 4),
                                            _buildStatRow(
                                              pokemon.stats!.def,
                                              230,
                                            ),
                                            const SizedBox(height: 4),
                                            _buildStatRow(
                                              pokemon.stats!.speAtk,
                                              194,
                                            ),
                                            const SizedBox(height: 4),
                                            _buildStatRow(
                                              pokemon.stats!.speDef,
                                              230,
                                            ),
                                            const SizedBox(height: 4),
                                            _buildStatRow(
                                              pokemon.stats!.vit,
                                              200,
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
                                    const Text(
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
                                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    const SizedBox(height: 8),
                                    const Text(
                                      "CATEGORY",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(pokemon.category),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "WEIGHT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(pokemon.weight),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "HEIGHT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatRow(int statValue, double maxVal) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(statValue.toString()),
      ),
      SizedBox(
        width: 100,
        height: 10,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: statValue / maxVal,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.grey[400],
          ),
        ),
      ),
    ],
  );
}
