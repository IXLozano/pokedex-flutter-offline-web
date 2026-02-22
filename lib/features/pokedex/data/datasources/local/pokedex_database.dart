import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'pokedex_database.g.dart';

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
class PokedexDatabase extends _$PokedexDatabase {
  PokedexDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<PokemonListCacheTableData>> watchPokemonPage({required int limit, required int offset}) {
    final query = select(pokemonListCacheTable)
      ..where((t) => t.pageOffset.equals(offset))
      ..orderBy([(t) => OrderingTerm.asc(t.position)])
      ..limit(limit);

    return query.watch();
  }

  Future<void> replacePokemonPage({required int offset, required List<PokemonListCacheTableCompanion> rows}) async {
    await transaction(() async {
      await (delete(pokemonListCacheTable)..where((t) => t.pageOffset.equals(offset))).go();

      if (rows.isNotEmpty) {
        await batch((b) => b.insertAll(pokemonListCacheTable, rows));
      }
    });
  }

  Stream<PokemonDetailCacheTableData?> watchPokemonDetail(int id) {
    final query = select(pokemonDetailCacheTable)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    return query.watchSingleOrNull();
  }

  Future<void> upsertPokemonDetail(PokemonDetailCacheTableCompanion row) {
    return into(pokemonDetailCacheTable).insertOnConflictUpdate(row);
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'pokedex_cache',
    web: DriftWebOptions(sqlite3Wasm: Uri.parse('sqlite3.wasm'), driftWorker: Uri.parse('drift_worker')),
  );
}
