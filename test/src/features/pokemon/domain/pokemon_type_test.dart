import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/domain/pokemon_type.dart';

void main() {
  group('PokemonType Tests', () {
    test('should initialize with provided values', () {
      const type = PokemonType(
        name: 'Feu',
        image:
            'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/plante.png',
      );

      expect(type.name, 'Feu');
      expect(
        type.image,
        'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/plante.png',
      );
    });

    test('should use empty string as default image when not provided', () {
      const type = PokemonType(name: 'Eau');

      expect(type.name, 'Eau');
      expect(type.image, '');
    });
  });
}
