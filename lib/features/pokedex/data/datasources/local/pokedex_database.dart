import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'pokedex_database.g.dart';

/// Drift table that stores cached pokemon list pages by offset and position.
class PokemonListCacheTable extends Table {
  IntColumn get pageOffset => integer()();
  IntColumn get position => integer()();
  IntColumn get pokemonId => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {pageOffset, position};
}

/// Drift table that stores one cached pokemon detail row per id.
class PokemonDetailCacheTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  IntColumn get height => integer()();
  IntColumn get weight => integer()();
  TextColumn get typesJson => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [PokemonListCacheTable, PokemonDetailCacheTable])
/// Drift database for all local cache entities used by the Pokedex feature.
class PokedexDatabase extends _$PokedexDatabase {
  PokedexDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Observes one cached page reactively for a given offset and limit.
  Stream<List<PokemonListCacheTableData>> watchPokemonPage({required int limit, required int offset}) {
    final query = select(pokemonListCacheTable)
      ..where((t) => t.pageOffset.equals(offset))
      ..orderBy([(t) => OrderingTerm.asc(t.position)])
      ..limit(limit);

    return query.watch();
  }

  /// Reads one cached page snapshot for a given offset and limit.
  Future<List<PokemonListCacheTableData>> getPokemonPage({required int limit, required int offset}) {
    final query = select(pokemonListCacheTable)
      ..where((t) => t.pageOffset.equals(offset))
      ..orderBy([(t) => OrderingTerm.asc(t.position)])
      ..limit(limit);

    return query.get();
  }

  /// Returns the latest updated timestamp for a cached page offset.
  Future<int?> getPokemonPageLatestTimeStamp({required int offset}) async {
    final query = select(pokemonListCacheTable)
      ..where((t) => t.pageOffset.equals(offset))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row?.updatedAt;
  }

  /// Replaces all rows for one page offset in a single transaction.
  Future<void> replacePokemonPage({required int offset, required List<PokemonListCacheTableCompanion> rows}) async {
    await transaction(() async {
      await (delete(pokemonListCacheTable)..where((t) => t.pageOffset.equals(offset))).go();

      if (rows.isNotEmpty) {
        await batch((b) => b.insertAll(pokemonListCacheTable, rows));
      }
    });
  }

  /// Observes one cached pokemon detail row by id.
  Stream<PokemonDetailCacheTableData?> watchPokemonDetail(int id) {
    final query = select(pokemonDetailCacheTable)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    return query.watchSingleOrNull();
  }

  /// Returns the updated timestamp for one cached detail row.
  Future<int?> getPokemonDetailLatestTimeStamp(int id) async {
    final query = select(pokemonDetailCacheTable)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row?.updatedAt;
  }

  /// Inserts or updates one cached detail row by primary key.
  Future<void> upsertPokemonDetail(PokemonDetailCacheTableCompanion row) {
    return into(pokemonDetailCacheTable).insertOnConflictUpdate(row);
  }
}

/// Opens a platform-aware Drift connection (including web wasm/worker setup).
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'pokedex_cache',
    web: DriftWebOptions(sqlite3Wasm: Uri.parse('sqlite3.wasm'), driftWorker: Uri.parse('drift_worker.js')),
  );
}
