import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonPage {
  final PokemonRepository _repository;

  GetPokemonPage({required PokemonRepository repository}) : _repository = repository;

  Stream<List<Pokemon>> watch({int limit = 20, int offset = 0}) =>
      _repository.watchPokemonPage(limit: limit, offset: offset);

  Future<List<Pokemon>> once({int limit = 20, int offset = 0}) =>
      _repository.getPokemonPageOnce(limit: limit, offset: offset);
}
