import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListResponseDto> fetchPokemonPage({required int limit, required int offset});

  Future<PokemonDetailDto> fetchPokemonDetail(int id);
}
