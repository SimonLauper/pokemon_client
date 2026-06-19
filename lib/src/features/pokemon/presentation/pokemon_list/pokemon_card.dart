import 'package:flutter/material.dart';
import 'package:pokemon_client/src/common_widgets/styled_type.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF7DCAA6),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 15.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      for (int i = 0; i < pokemon.types.length; i++)
                        Column(
                          children: [
                            SizedBox(height: 12),
                            SizedBox(
                              width: 120,
                              child: StyledType(type: pokemon.types[i].name),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.network(pokemon.sprites.regular, width: 100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
