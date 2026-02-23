import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

/// Maps list DTO items into lightweight domain entities.
extension PokemonListItemDtoMapper on PokemonListItemDto {
  /// Converts one list DTO item into a [Pokemon] entity.
  Pokemon toEntity() {
    try {
      final id = _extractIdFromUrl(url);
      return Pokemon(id: id, name: name, imageUrl: id > 0 ? _buildImageUrl(id) : '');
    } on FormatException catch (e) {
      throw ParsingException(message: e.message);
    } catch (_) {
      throw ParsingException(message: 'Invalid pokemon list item: name=$name, url=$url');
    }
  }
}

/// Maps detail DTO payloads into rich domain entities.
extension PokemonDetialDtoMapper on PokemonDetailDto {
  /// Converts one detail DTO into a [PokemonDetail] entity.
  PokemonDetail toEntity() {
    return PokemonDetail(id: id, name: name, imageUrl: imageUrl, height: height, weight: weight, types: types);
  }
}

/// Extracts the numeric pokemon id from the resource URL.
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

/// Builds the list thumbnail URL from a pokemon id.
String _buildImageUrl(int id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
