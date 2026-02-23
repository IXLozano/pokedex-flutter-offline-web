import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';

/// Fake repository used to control list-page responses in cubit tests.
class _FakePokemonRepository implements PokemonRepository {
  final Map<int, Future<List<Pokemon>> Function()> _pagesByOffset;

  _FakePokemonRepository(this._pagesByOffset);

  /// Returns configured page data for the requested offset.
  @override
  Future<List<Pokemon>> getPokemonPageOnce({required int limit, required int offset}) {
    final loader = _pagesByOffset[offset];
    if (loader == null) return Future.value(const <Pokemon>[]);
    return loader();
  }

  /// Not used in list cubit tests.
  @override
  Stream<PokemonDetail> watchPokemonDetail(int id) => const Stream.empty();
}

/// Entry point for pokemon list cubit tests.
void main() {
  group('PokemonListCubit', () {
    test('fetchNextPage keeps previous data when request fails and emits UI event', () async {
      final initial = List<Pokemon>.generate(
        20,
        (i) => Pokemon(id: i + 1, name: 'p$i', imageUrl: 'url_$i'),
      );

      final repository = _FakePokemonRepository({
        0: () async => initial,
        20: () async => throw const NetworkFailure('No internet'),
      });
      final cubit = PokemonListCubit(getPokemonPage: GetPokemonPage(repository: repository));

      final emittedStates = <PokemonListState>[];
      final statesSub = cubit.stream.listen(emittedStates.add);
      final uiEvents = <String>[];
      final uiSub = cubit.uiEvents.listen(uiEvents.add);

      await cubit.fetchInitial();
      await cubit.fetchNextPage();
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<PokemonListData>());
      final state = cubit.state as PokemonListData;
      expect(state.pokemons.length, 20);
      expect(state.isRefreshing, false);
      expect(uiEvents, contains('No internet'));
      expect(
        emittedStates.whereType<PokemonListError>(),
        isEmpty,
        reason: 'Pagination failure with cached data should not replace screen with full error',
      );

      await uiSub.cancel();
      await statesSub.cancel();
      await cubit.close();
    });
  });
}
