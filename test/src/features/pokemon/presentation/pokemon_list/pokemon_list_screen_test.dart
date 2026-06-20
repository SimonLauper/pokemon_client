import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';

class FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  group('PokemonListScreen', () {
    setUpAll(() {
      HttpOverrides.global = FakeHttpOverrides();
    });

    testWidgets('Show pokemons name from list', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: PokemonListScreen())),
      );

      await tester.pumpAndSettle();
      expect(find.text('Bulbizarre'), findsOne);
      expect(find.text('Herbizarre'), findsOne);
      expect(find.text('Florizarre'), findsOne);
    });

    testWidgets('filter pokemon list by type with Dropdown', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: PokemonListScreen())),
      );

      await tester.pumpAndSettle();

      expect(find.text('Bulbizarre'), findsOne);
      expect(find.text('Salamèche'), findsOne);

      final dropdown = find.byType(DropdownButton<String>);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final feuItem = find.text('Feu').last;
      await tester.tap(feuItem);
      await tester.pumpAndSettle();

      expect(find.text('Salamèche'), findsOne);
      expect(find.text('Bulbizarre'), findsNothing);
    });
  });
}
