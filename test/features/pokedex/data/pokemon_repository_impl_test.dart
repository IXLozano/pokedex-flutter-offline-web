import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokemon_local_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';

/// Fake local datasource with in-memory storage for repository tests.
class _FakeLocalDataSource implements PokemonLocalDataSource {
  List<Pokemon> _page0 = const <Pokemon>[];
  int? _page0UpdatedAt;
  final _detailsById = <int, PokemonDetail?>{};
  final _detailControllers = <int, StreamController<PokemonDetail?>>{};
  final _detailUpdatedAt = <int, int?>{};

  /// Returns a cached page for the provided offset.
  @override
  Future<List<Pokemon>> getPokemonPage({required int limit, required int offset}) async {
    if (offset == 0) return _page0;
    return const <Pokemon>[];
  }

  /// Returns a page-level updated timestamp for TTL checks.
  @override
  Future<int?> getPokemonPageLatestTimeStamp({required int offset}) async {
    if (offset == 0) return _page0UpdatedAt;
    return null;
  }

  /// Persists one list page in fake local storage.
  @override
  Future<void> savePokemonPage({required int offset, required List<Pokemon> pokemons}) async {
    if (offset == 0) {
      _page0 = pokemons;
      _page0UpdatedAt = DateTime.now().millisecondsSinceEpoch;
    }
  }

  /// Watches cached detail values and emits current value on subscription.
  @override
  Stream<PokemonDetail?> watchPokemonDetail(int id) {
    final controller = _detailControllers.putIfAbsent(id, () => StreamController<PokemonDetail?>.broadcast());
    return Stream<PokemonDetail?>.multi((multi) {
      multi.add(_detailsById[id]);
      final sub = controller.stream.listen(
        multi.add,
        onError: multi.addError,
        onDone: multi.close,
      );
      multi.onCancel = sub.cancel;
    });
  }

  /// Pushes one detail value into the watched stream for the provided id.
  void emitDetail(int id, PokemonDetail? detail) {
    _detailsById[id] = detail;
    final controller = _detailControllers.putIfAbsent(id, () => StreamController<PokemonDetail?>.broadcast());
    controller.add(detail);
  }

  /// Returns detail-level updated timestamp for TTL checks.
  @override
  Future<int?> getPokemonDetailLatestTimeStamp(int id) async {
    return _detailUpdatedAt[id];
  }

  /// Persists one detail value and emits it to active watchers.
  @override
  Future<void> savePokemonDetail(PokemonDetail detail) async {
    _detailUpdatedAt[detail.id] = DateTime.now().millisecondsSinceEpoch;
    _detailsById[detail.id] = detail;
    emitDetail(detail.id, detail);
  }
}

/// Fake remote datasource with configurable callbacks for repository tests.
class _FakeRemoteDataSource implements PokemonRemoteDataSource {
  int fetchPageCalls = 0;
  int fetchDetailCalls = 0;
  Future<PokemonListResponseDto> Function({required int limit, required int offset})? onFetchPage;
  Future<PokemonDetailDto> Function(int id)? onFetchDetail;

  /// Executes configured list callback and tracks invocation count.
  @override
  Future<PokemonListResponseDto> fetchPokemonPage({required int limit, required int offset}) {
    fetchPageCalls++;
    return onFetchPage!(limit: limit, offset: offset);
  }

  /// Executes configured detail callback and tracks invocation count.
  @override
  Future<PokemonDetailDto> fetchPokemonDetail(int id) {
    fetchDetailCalls++;
    return onFetchDetail!(id);
  }
}

/// Entry point for pokemon repository implementation tests.
void main() {
  group('PokemonRepositoryImpl', () {
    test('getPokemonPageOnce cache miss fetches remote, saves local, and returns local snapshot', () async {
      final local = _FakeLocalDataSource();
      final remote = _FakeRemoteDataSource()
        ..onFetchPage = ({required int limit, required int offset}) async {
          return PokemonListResponseDto(
            count: 1,
            next: null,
            previous: null,
            results: [PokemonListItemDto(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/')],
          );
        };

      final repository = PokemonRepositoryImpl(remote: remote, local: local);
      final result = await repository.getPokemonPageOnce(limit: 20, offset: 0);

      expect(remote.fetchPageCalls, 1);
      expect(result, isNotEmpty);
      expect(result.first.id, 1);
      expect(result.first.name, 'bulbasaur');
    });

    test('watchPokemonDetail without cache propagates failure if remote request fails', () async {
      final local = _FakeLocalDataSource();
      final remote = _FakeRemoteDataSource()
        ..onFetchDetail = (id) async => throw NetworkException(message: 'Network down');

      final repository = PokemonRepositoryImpl(remote: remote, local: local);

      await expectLater(
        repository.watchPokemonDetail(25),
        emitsError(
          isA<NetworkFailure>().having((f) => f.message, 'message', contains('Network down')),
        ),
      );
    });
  });
}
