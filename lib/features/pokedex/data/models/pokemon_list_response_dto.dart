class PokemonListResponseDto {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItemDto> results;

  PokemonListResponseDto({required this.count, required this.next, required this.previous, required this.results});

  factory PokemonListResponseDto.fromJson(Map<String, dynamic> json) {
    return PokemonListResponseDto(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List).map((e) => PokemonListItemDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class PokemonListItemDto {
  final String name;
  final String url;

  PokemonListItemDto({required this.name, required this.url});

  factory PokemonListItemDto.fromJson(Map<String, dynamic> json) {
    return PokemonListItemDto(name: json['name'] as String, url: json['url'] as String);
  }
}
