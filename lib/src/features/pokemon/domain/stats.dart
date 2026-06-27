class Stats {
  const Stats({
    required this.hp,
    required this.atk,
    required this.def,
    required this.speAtk,
    required this.speDef,
    required this.vit,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    int parseField(String key) {
      final value = json[key];
      if (value is! int) {
        throw FormatException(
          'JSON invalide : $key doit être int, reçu: $value',
        );
      }
      return value;
    }

    return Stats(
      hp: parseField('hp'),
      atk: parseField('atk'),
      def: parseField('def'),
      speAtk: parseField('spe_atk'),
      speDef: parseField('spe_def'),
      vit: parseField('vit'),
    );
  }

  final int hp;
  final int atk;
  final int def;
  final int speAtk;
  final int speDef;
  final int vit;
}
