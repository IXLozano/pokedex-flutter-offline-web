import 'dart:async';

import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

/// Repository implementation that coordinates remote fetches and local cache access.
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _remote;
  final PokemonLocalDataSource _local;
  static const Duration _cacheTtl = Duration(hours: 1);

  PokemonRepositoryImpl({required PokemonRemoteDataSource remote, required PokemonLocalDataSource local})
    : _remote = remote,
      _local = local;

  /// Returns one pokemon page using cache-first behavior with background revalidation.
  @override
  Future<List<Pokemon>> getPokemonPageOnce({required int limit, required int offset}) async {
    return _execute(() async {
      final cached = await _local.getPokemonPage(limit: limit, offset: offset);
      if (cached.isNotEmpty) {
        final updatedAt = await _local.getPokemonPageLatestTimeStamp(offset: offset);
        if (_isStale(updatedAt)) {
          unawaited(_revalidatePage(limit: limit, offset: offset));
        }
        return cached;
      }

      final remotePokemons = await _fetchRemotePage(limit: limit, offset: offset);
      await _local.savePokemonPage(offset: offset, pokemons: remotePokemons);

      final persistedPage = await _local.getPokemonPage(limit: limit, offset: offset);
      if (persistedPage.isNotEmpty) {
        return persistedPage;
      }

      return remotePokemons;
    });
  }

  /// Returns one pokemon detail from cache when possible, with remote fallback.
  @override
  Stream<PokemonDetail> watchPokemonDetail(int id) async* {
    final detail = await _execute(() async {
      final cachedDetail = await _local.watchPokemonDetail(id).first;
      if (cachedDetail != null) {
        final updatedAt = await _local.getPokemonDetailLatestTimeStamp(id);
        if (_isStale(updatedAt)) {
          unawaited(_revalidateDetail(id));
        }
        return cachedDetail;
      }

      final remoteDetail = await _fetchRemoteDetail(id);
      await _local.savePokemonDetail(remoteDetail);

      return await _local.watchPokemonDetail(id).first ?? remoteDetail;
    });

    yield detail;
  }

  /// Checks whether cached data is older than the configured TTL window.
  bool _isStale(int? updatedAt) {
    if (updatedAt == null) return true;
    final now = DateTime.now().millisecondsSinceEpoch;
    return now - updatedAt > _cacheTtl.inMilliseconds;
  }

  /// Refreshes one list page from remote and updates local cache in background.
  Future<void> _revalidatePage({required int limit, required int offset, bool swallowErrors = true}) async {
    try {
      await _execute(() async {
        final remotePokemons = await _fetchRemotePage(limit: limit, offset: offset);
        await _local.savePokemonPage(offset: offset, pokemons: remotePokemons);
      });
    } on Failure {
      if (!swallowErrors) rethrow;
    } catch (_) {
      if (!swallowErrors) rethrow;
    }
  }

  /// Refreshes one detail payload from remote and updates local cache in background.
  Future<void> _revalidateDetail(int id) async {
    try {
      await _execute(() async {
        final remoteDetail = await _fetchRemoteDetail(id);
        await _local.savePokemonDetail(remoteDetail);
      });
    } on Failure {
      // Ignore background revalidation errors to keep local stream as source of truth.
    } catch (_) {
      // Ignore unexpected background revalidation errors.
    }
  }

  /// Fetches one list page from API and maps DTOs into domain entities.
  Future<List<Pokemon>> _fetchRemotePage({required int limit, required int offset}) async {
    final response = await _remote.fetchPokemonPage(limit: limit, offset: offset);
    return response.results.map((e) => e.toEntity()).toList();
  }

  /// Fetches one detail payload from API and maps it into a domain entity.
  Future<PokemonDetail> _fetchRemoteDetail(int id) async {
    final response = await _remote.fetchPokemonDetail(id);
    return response.toEntity();
  }

  /// Executes repository actions and maps data exceptions into domain failures.
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
