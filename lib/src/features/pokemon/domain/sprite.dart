class Sprite {
  const Sprite({required this.regular, required this.shiny});

  factory Sprite.fromJson(Map<String, dynamic> json) {
    final regular = json['regular'] as String? ?? "";
    final shiny = json['shiny'] as String? ?? regular;
    return Sprite(regular: regular, shiny: shiny);
  }

  final String regular;
  final String shiny;
}
