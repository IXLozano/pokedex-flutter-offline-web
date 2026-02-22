import 'dart:async';

import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;

  PokemonRepositoryImpl({required PokemonRemoteDataSource remote, required PokemonLocalDataSource local})
    : _remote = remote,
      _local = local;

  @override
  Stream<List<Pokemon>> watchPokemonPage({required int limit, required int offset}) {
    return _local.watchPokemonPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Pokemon>> getPokemonPageOnce({required int limit, required int offset}) async {
    final cached = await _local.getPokemonPage(limit: limit, offset: offset);
    if (cached.isNotEmpty) {
      unawaited(_revalidatePage(limit: limit, offset: offset));
      return cached;
    }

    final remotePokemons = await _execute(
      () => _remote
          .fetchPokemonPage(limit: limit, offset: offset)
          .then((response) => response.results.map((e) => e.toEntity()).toList()),
    );

    await _execute(() => _local.savePokemonPage(offset: offset, pokemons: remotePokemons));
    return remotePokemons;
  }

  @override
  Stream<PokemonDetail> watchPokemonDetail(int id) {
    unawaited(_revalidateDetail(id));
    return _local.watchPokemonDetail(id).where((detail) => detail != null).cast<PokemonDetail>();
  }

  Future<void> _revalidatePage({required int limit, required int offset, bool swallowErrors = true}) async {
    try {
      final remotePokemons = await _execute(
        () => _remote
            .fetchPokemonPage(limit: limit, offset: offset)
            .then((response) => response.results.map((e) => e.toEntity()).toList()),
      );
      await _execute(() => _local.savePokemonPage(offset: offset, pokemons: remotePokemons));
    } on Failure {
      if (!swallowErrors) rethrow;
    } catch (_) {
      if (!swallowErrors) rethrow;
    }
  }

  Future<void> _revalidateDetail(int id) async {
    try {
      final remoteDetail = await _execute(() => _remote.fetchPokemonDetail(id).then((response) => response.toEntity()));

      await _execute(() => _local.savePokemonDetail(remoteDetail));
    } on Failure {
      // Ignore background revalidation errors to keep local stream as source of truth.
    } catch (_) {
      // Ignore unexpected background revalidation errors.
    }
  }

  Future<T> _execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } on ParsingException catch (e) {
      throw UnknownFailure(e.message);
    } catch (_) {
      throw UnknownFailure('Unexpected error');
    }
  }
}
