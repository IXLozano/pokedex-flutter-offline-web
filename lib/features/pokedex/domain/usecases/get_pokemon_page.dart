import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

/// Use case that loads a single paginated pokemon batch.
class GetPokemonPage {
  final PokemonRepository _repository;

  GetPokemonPage({required PokemonRepository repository}) : _repository = repository;

  /// Executes one list-page request using repository cache strategy.
  Future<List<Pokemon>> call({int limit = 20, int offset = 0}) =>
      _repository.getPokemonPageOnce(limit: limit, offset: offset);
}
