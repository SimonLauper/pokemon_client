import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_client/src/features/pokemon/domain/stats.dart';

void main() {
  group('Stats Tests', () {
    test('should correctly assign all base stats', () {
      const stats = Stats(
        hp: 45,
        atk: 49,
        def: 49,
        speAtk: 65,
        speDef: 65,
        vit: 45,
      );

      expect(stats.hp, 45);
      expect(stats.atk, 49);
      expect(stats.def, 49);
      expect(stats.speAtk, 65);
      expect(stats.speDef, 65);
      expect(stats.vit, 45);
    });
  });
}
