import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonPage getPokemonPage;

  final int _limit = 20;
  bool _isFetching = false;
  StreamSubscription<List<Pokemon>>? _firstPageSubscription;

  PokemonListCubit({required this.getPokemonPage}) : super(PokemonListInitial());

  Future<void> fetchInitial() {
    return _execute(() async {
      emit(PokemonListLoading());
      _isFetching = false;
      await _firstPageSubscription?.cancel();

      final initialPage = await getPokemonPage.once(limit: _limit, offset: 0);
      if (initialPage.isEmpty) {
        emit(PokemonListError(message: 'No cached data and no network response.'));
        return;
      }

      emit(PokemonListData(pokemons: initialPage, hasReachedMax: initialPage.length < _limit));

      _firstPageSubscription = getPokemonPage.watch(limit: _limit, offset: 0).listen((pokemons) {
        if (pokemons.isEmpty) return;
        final current = state;
        if (current is PokemonListData && current.pokemons.length > _limit) return;
        emit(PokemonListData(pokemons: pokemons, hasReachedMax: pokemons.length < _limit));
      });
    });
  }

  Future<void> fetchNextPage() {
    if (_isFetching) return Future.value();

    return _execute(() async {
      final currentState = state;

      if (currentState is! PokemonListData) return;
      if (currentState.hasReachedMax) return;

      _isFetching = true;
      emit(currentState.copyWith(isRefreshing: true));

      final offset = currentState.pokemons.length;

      try {
        final newPokemons = await getPokemonPage.once(limit: _limit, offset: offset);

        if (newPokemons.isEmpty) {
          emit(currentState.copyWith(isRefreshing: false));
          return;
        }

        final hasReachedMax = newPokemons.length < _limit;
        final accumulated = [...currentState.pokemons, ...newPokemons];

        emit(PokemonListData(pokemons: accumulated, isRefreshing: false, hasReachedMax: hasReachedMax));
      } catch (_) {
        emit(currentState.copyWith(isRefreshing: false));
        rethrow;
      } finally {
        _isFetching = false;
      }
    });
  }

  Future<void> _execute(Future<void> Function() action) async {
    try {
      await action();
    } on Failure catch (f) {
      emit(PokemonListError(message: f.message));
    } catch (f) {
      emit(PokemonListError(message: 'Unexpected error: ${f.toString()}'));
    }
  }

  @override
  Future<void> close() async {
    await _firstPageSubscription?.cancel();
    return super.close();
  }
}
