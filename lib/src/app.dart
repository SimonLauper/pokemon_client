import 'package:flutter/material.dart';
import 'package:pokemon_client/src/routes/app_router.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: PokedexTheme.themeData,
      routerConfig: goRouter,
    );
  }
}
