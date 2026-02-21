import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

abstract class PokemonLocalDatasource {
  Stream<List<Pokemon>> watchPokemonPage({required int limit, required int offset});

  Future<void> savePokemonPage({required int offset, required List<Pokemon> pokemons});

  Stream<PokemonDetail?> watchPokemonDetail(int id);

  Future<void> savePokemonDetail(PokemonDetail detail);
}
