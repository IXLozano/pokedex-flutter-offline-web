import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonPage getPokemonPage;
  final StreamController<String> _uiEvents = StreamController<String>.broadcast();

  final int _limit = 20;
  final Duration _paginationErrorCooldown = const Duration(seconds: 4);
  bool _isFetching = false;
  DateTime? _lastPaginationErrorAt;

  PokemonListCubit({required this.getPokemonPage}) : super(PokemonListInitial());

  Stream<String> get uiEvents => _uiEvents.stream;

  Future<void> fetchInitial() {
    return _execute(() async {
      emit(PokemonListLoading());
      _isFetching = false;

      final initialPage = await getPokemonPage.once(limit: _limit, offset: 0);

      if (initialPage.isEmpty) {
        emit(PokemonListEmpty());
        return;
      }

      emit(PokemonListData(pokemons: initialPage, hasReachedMax: initialPage.length < _limit));
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
      } on Failure catch (f) {
        emit(currentState.copyWith(isRefreshing: false));
        _emitPaginationError(f.message);
      } catch (_) {
        emit(currentState.copyWith(isRefreshing: false));
        _emitPaginationError('Unexpected error while loading more pokemons.');
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

  void _emitPaginationError(String message) {
    final now = DateTime.now();
    final last = _lastPaginationErrorAt;
    if (last != null && now.difference(last) < _paginationErrorCooldown) return;
    _lastPaginationErrorAt = now;
    _uiEvents.add(message);
  }

  @override
  Future<void> close() async {
    await _uiEvents.close();
    return super.close();
  }
}
