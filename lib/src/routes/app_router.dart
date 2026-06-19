import 'package:go_router/go_router.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_details/pokemon_details_screen.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';

enum AppRoute { home, detail }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const PokemonListScreen(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          name: AppRoute.detail.name,
          builder: (context, state) {
            final pokedexId = state.pathParameters['id']!;
            return PokemonDetailsScreen(pokedexId: pokedexId);
          },
        ),
      ],
    ),
  ],
);
