import 'package:flutter/material.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokemonListScreen(),
    );
  }
}
