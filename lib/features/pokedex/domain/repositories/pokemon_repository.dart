import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

/// Domain contract that defines list and detail access for the Pokedex feature.
abstract class PokemonRepository {
  /// Returns one page of pokemon using cache-first behavior with optional revalidation.
  Future<List<Pokemon>> getPokemonPageOnce({required int limit, required int offset});

  /// Emits one detail payload backed by local cache and remote fallback.
  Stream<PokemonDetail> watchPokemonDetail(int id);
}
