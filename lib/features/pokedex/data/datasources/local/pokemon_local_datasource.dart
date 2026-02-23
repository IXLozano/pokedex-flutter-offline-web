import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

/// Local contract for reading and persisting pokemon cache data.
abstract class PokemonLocalDataSource {
  /// Returns one cached list page for the given pagination window.
  Future<List<Pokemon>> getPokemonPage({required int limit, required int offset});

  /// Returns the latest update timestamp for a cached list page.
  Future<int?> getPokemonPageLatestTimeStamp({required int offset});

  /// Persists or replaces one cached list page.
  Future<void> savePokemonPage({required int offset, required List<Pokemon> pokemons});

  /// Observes one cached pokemon detail row by id.
  Stream<PokemonDetail?> watchPokemonDetail(int id);

  /// Returns the latest update timestamp for one cached detail row.
  Future<int?> getPokemonDetailLatestTimeStamp(int id);

  /// Persists one pokemon detail row in cache.
  Future<void> savePokemonDetail(PokemonDetail detail);
}
