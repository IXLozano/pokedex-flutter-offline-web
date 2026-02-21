import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

abstract class PokemonRepository {
  Stream<List<Pokemon>> watchPokemonPage({required int limit, required int offset});

  Stream<PokemonDetail> watchPokemonDetail(int id);
}
