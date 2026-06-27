class PokemonType {
  const PokemonType({required this.name, this.image = ""});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? "";
    if (name is! String) {
      throw FormatException(
        'JSON invalide : name doit être de type String dans $json',
      );
    }
    final image = json['image'] ?? "";
    if (image is! String) {
      throw FormatException(
        'JSON invalide : name doit être de type String dans $json',
      );
    }

    return PokemonType(name: name, image: image);
  }

  final String name;
  final String image;
}
