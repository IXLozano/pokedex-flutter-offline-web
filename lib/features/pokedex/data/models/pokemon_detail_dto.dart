import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';

/// DTO for the pokemon detail endpoint payload.
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

  /// Parses the detail endpoint JSON into a strongly typed DTO.
  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    try {
      return PokemonDetailDto(
        id: json['id'] as int,
        name: json['name'] as String,
        height: json['height'] as int,
        weight: json['weight'] as int,
        imageUrl: (json['sprites']?['front_default'] as String?) ?? '',
        types: (json['types'] as List).map((e) => e['type']['name'] as String).toList(),
        stats: (json['stats'] as List).map((e) => PokemonStatDto.fromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e) {
      throw ParsingException(message: 'Invalid pokemon detail response: ${e.toString()}');
    }
  }
}

/// DTO for one pokemon stat entry inside detail payload.
class PokemonStatDto {
  final String name;
  final int value;

  PokemonStatDto({required this.name, required this.value});

  /// Parses one stat JSON object.
  factory PokemonStatDto.fromJson(Map<String, dynamic> json) {
    try {
      return PokemonStatDto(name: json['stat']['name'] as String, value: json['base_stat'] as int);
    } catch (e) {
      throw ParsingException(message: 'Invalid pokemon stat item: ${e.toString()}');
    }
  }
}
