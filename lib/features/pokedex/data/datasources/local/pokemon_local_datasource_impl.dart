import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokedex_database.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

/// Drift-backed implementation of local pokemon cache operations.
class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final PokedexDatabase _db;

  PokemonLocalDataSourceImpl({required PokedexDatabase db}) : _db = db;

  /// Reads one cached list page and maps rows into domain entities.
  @override
  Future<List<Pokemon>> getPokemonPage({required int limit, required int offset}) async {
    return _execute(() async {
      final rows = await _db.getPokemonPage(limit: limit, offset: offset);
      return rows.map((row) => Pokemon(id: row.pokemonId, name: row.name, imageUrl: row.imageUrl)).toList();
    });
  }

  /// Reads the last update timestamp for a cached list page.
  @override
  Future<int?> getPokemonPageLatestTimeStamp({required int offset}) {
    return _execute(() => _db.getPokemonPageLatestTimeStamp(offset: offset));
  }

  /// Replaces one cached list page with the provided domain entities.
  @override
  Future<void> savePokemonPage({required int offset, required List<Pokemon> pokemons}) async {
    await _execute(() async {
      final now = DateTime.now().millisecondsSinceEpoch;

      final rows = pokemons.asMap().entries.map((row) {
        final position = row.key;
        final pokemon = row.value;

        return PokemonListCacheTableCompanion.insert(
          pageOffset: offset,
          position: position,
          pokemonId: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.imageUrl,
          updatedAt: now,
        );
      }).toList();

      await _db.replacePokemonPage(offset: offset, rows: rows);
    });
  }

  /// Observes one cached detail row and maps it into a domain entity.
  @override
  Stream<PokemonDetail?> watchPokemonDetail(int id) {
    return _db.watchPokemonDetail(id).map((row) {
      if (row == null) return null;

      return PokemonDetail(
        id: row.id,
        name: row.name,
        imageUrl: row.imageUrl,
        height: row.height,
        weight: row.weight,
        types: List<String>.from(jsonDecode(row.typesJson) as List),
      );
    });
  }

  /// Reads the last update timestamp for one cached detail row.
  @override
  Future<int?> getPokemonDetailLatestTimeStamp(int id) {
    return _execute(() => _db.getPokemonDetailLatestTimeStamp(id));
  }

  /// Upserts one detail entity into local cache.
  @override
  Future<void> savePokemonDetail(PokemonDetail detail) async {
    await _execute(() async {
      final now = DateTime.now().millisecondsSinceEpoch;

      final row = PokemonDetailCacheTableCompanion.insert(
        id: Value(detail.id),
        name: detail.name,
        imageUrl: detail.imageUrl,
        height: detail.height,
        weight: detail.weight,
        typesJson: jsonEncode(detail.types),
        updatedAt: now,
      );

      await _db.upsertPokemonDetail(row);
    });
  }

  /// Wraps local database operations and maps unexpected failures to cache exceptions.
  Future<T> _execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (e) {
      throw CacheException(message: 'Local cache operation failed: ${e.toString()}');
    }
  }
}
