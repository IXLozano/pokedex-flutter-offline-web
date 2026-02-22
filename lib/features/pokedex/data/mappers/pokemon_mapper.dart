import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

extension PokemonListItemDtoMapper on PokemonListItemDto {
  Pokemon toEntity() {
    final id = _extractIdFromUrl(url);
    return Pokemon(id: id, name: name, imageUrl: id > 0 ? _buildImageUrl(id) : '');
  }
}

extension PokemonDetialDtoMapper on PokemonDetailDto {
  PokemonDetail toEntity() =>
      PokemonDetail(id: id, name: name, imageUrl: imageUrl, height: height, weight: weight, types: types);
}

int _extractIdFromUrl(String url) {
  final uri = Uri.parse(url);
  final segments = uri.pathSegments.where((e) => e.isNotEmpty).toList();

  final last = segments.isNotEmpty ? segments.last : '';
  final parsed = int.tryParse(last);

  if (parsed == null) {
    throw FormatException('Invalid pokemon url: $url');
  }

  return parsed;
}

String _buildImageUrl(int id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
