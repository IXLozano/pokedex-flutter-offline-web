class PokemonDetailDto {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> types;
  final List<PokemonStatDto> stats;

  PokemonDetailDto({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
    required this.stats,
  });

  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) => PokemonDetailDto(
    id: json['id'] as int,
    name: json['name'] as String,
    height: json['height'] as int,
    weight: json['weight'] as int,
    imageUrl: json['sprites']['front_default'] as String,
    types: (json['types'] as List).map((e) => e['type']['name'] as String).toList(),
    stats: (json['stats'] as List).map((e) => PokemonStatDto.fromJson(e)).toList(),
  );
}

class PokemonStatDto {
  final String name;
  final int value;

  PokemonStatDto({required this.name, required this.value});

  factory PokemonStatDto.fromJson(Map<String, dynamic> json) =>
      PokemonStatDto(name: json['stat']['name'] as String, value: json['base_stat'] as int);
}
