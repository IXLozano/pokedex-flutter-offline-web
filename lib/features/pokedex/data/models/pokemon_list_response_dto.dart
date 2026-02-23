import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';

/// DTO for the pokemon list endpoint payload.
class PokemonListResponseDto {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItemDto> results;

  PokemonListResponseDto({required this.count, required this.next, required this.previous, required this.results});

  /// Parses the list endpoint JSON into a strongly typed DTO.
  factory PokemonListResponseDto.fromJson(Map<String, dynamic> json) {
    try {
      return PokemonListResponseDto(
        count: json['count'] as int,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        results: (json['results'] as List).map((e) => PokemonListItemDto.fromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e) {
      throw ParsingException(message: 'Invalid pokemon list response: ${e.toString()}');
    }
  }
}

/// DTO for a single pokemon entry inside list results.
class PokemonListItemDto {
  final String name;
  final String url;

  PokemonListItemDto({required this.name, required this.url});

  /// Parses one list item JSON object.
  factory PokemonListItemDto.fromJson(Map<String, dynamic> json) {
    try {
      return PokemonListItemDto(name: json['name'] as String, url: json['url'] as String);
    } catch (e) {
      throw ParsingException(message: 'Invalid pokemon list item: ${e.toString()}');
    }
  }
}
