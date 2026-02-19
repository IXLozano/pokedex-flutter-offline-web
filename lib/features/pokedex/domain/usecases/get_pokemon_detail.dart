import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository _repository;

  GetPokemonDetail({required PokemonRepository repository}) : _repository = repository;

  Future<PokemonDetail> call(int id) => _repository.getPokemonDetail(id);
}
