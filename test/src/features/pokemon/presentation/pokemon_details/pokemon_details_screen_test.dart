import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/presentation/pokemon_details/pokemon_details_screen.dart';

class FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  group('PokemonDetailsScreen Tests', () {
    setUpAll(() {
      HttpOverrides.global = FakeHttpOverrides();
    });
    testWidgets('Show correctly the Pokemon information and stats', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: PokemonDetailsScreen(pokedexId: '1')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Bulbizarre'), findsOneWidget);
      expect(find.text('N°1'), findsOneWidget);

      final hpStatFinder = find.text('45').at(0);
      expect(hpStatFinder, findsOneWidget);

      final attackStatFinder = find.text('45').at(1);
      expect(attackStatFinder, findsOneWidget);

      final defenseStatFinder = find.text('45').at(2);
      expect(defenseStatFinder, findsOneWidget);
    });
  });
}
