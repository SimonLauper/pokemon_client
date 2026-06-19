import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/domain/sprite.dart';

void main() {
  group('Sprite Tests', () {
    test('should initialize with provided regular and shiny URLs', () {
      const sprite = Sprite(
        regular:
            'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png',
        shiny:
            'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/shiny.png',
      );

      expect(
        sprite.regular,
        'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png',
      );
      expect(
        sprite.shiny,
        'https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/shiny.png',
      );
    });
  });
}
