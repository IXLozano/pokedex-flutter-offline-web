import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';

/// Remote contract for reading pokemon list and detail payloads from API.
abstract class PokemonRemoteDataSource {
  /// Fetches one paginated list payload from the remote endpoint.
  Future<PokemonListResponseDto> fetchPokemonPage({required int limit, required int offset});

  /// Fetches one pokemon detail payload by id from the remote endpoint.
  Future<PokemonDetailDto> fetchPokemonDetail(int id);
}
