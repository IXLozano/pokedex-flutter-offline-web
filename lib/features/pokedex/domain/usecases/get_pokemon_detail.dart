import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

/// Use case that loads one pokemon detail from the repository contract.
class GetPokemonDetail {
  final PokemonRepository _repository;

  GetPokemonDetail({required PokemonRepository repository}) : _repository = repository;

  /// Executes the detail request flow for the provided pokemon id.
  Stream<PokemonDetail> call(int id) => _repository.watchPokemonDetail(id);
}
