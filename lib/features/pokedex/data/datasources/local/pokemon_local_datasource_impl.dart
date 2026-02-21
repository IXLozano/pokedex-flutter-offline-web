import 'dart:convert';

import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokedex_database.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

class PokemonLocalDataSourceImpl implements PokemonLocalDatasource {
  final PokedexDatabase _db;

  PokemonLocalDataSourceImpl({required PokedexDatabase db}) : _db = db;

  @override
  Stream<List<Pokemon>> watchPokemonPage({required int limit, required int offset}) {
    return _db
        .watchPokemonPage(limit: limit, offset: offset)
        .map((rows) => rows.map((row) => Pokemon(id: row.pokemonId, name: row.name, imageUrl: row.imageUrl)).toList());
  }

  @override
  Future<void> savePokemonPage({required int offset, required List<Pokemon> pokemons}) async {
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
  }

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

  @override
  Future<void> savePokemonDetail(PokemonDetail detail) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final row = PokemonDetailCacheTableCompanion.insert(
      name: detail.name,
      imageUrl: detail.imageUrl,
      height: detail.height,
      weight: detail.weight,
      typesJson: jsonEncode(detail.types),
      updatedAt: now,
    );

    await _db.upsertPokemonDetail(row);
  }
}
