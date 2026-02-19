import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonPage {
  final PokemonRepository _repository;

  GetPokemonPage({required PokemonRepository repository}) : _repository = repository;

  Future<List<Pokemon>> call({int limit = 20, int offset = 0}) =>
      _repository.getPokemonPage(limit: limit, offset: offset);
}
