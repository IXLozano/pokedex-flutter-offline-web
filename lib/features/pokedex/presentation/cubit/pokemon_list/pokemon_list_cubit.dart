import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonPage getPokemonPage;

  int _offset = 0;
  final int _limit = 20;
  bool _isFetching = false;

  PokemonListCubit({required this.getPokemonPage}) : super(PokemonListInitial());

  Future<void> fetchInitial() {
    return _execute(() async {
      emit(PokemonListLoading());

      _offset = 0;
      _isFetching = false;

      await Future.delayed(const Duration(seconds: 2));
      List<Pokemon> latestPokemons = const [];

      await for (final pokemons in getPokemonPage(limit: _limit, offset: _offset)) {
        latestPokemons = pokemons;
        emit(PokemonListData(pokemons: pokemons, hasReachedMax: pokemons.length < _limit));
      }

      _offset = latestPokemons.length;
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

      List<Pokemon> accumulated = currentState.pokemons;
      bool hasReachedMax = currentState.hasReachedMax;

      try {
        await for (final newPokemons in getPokemonPage(limit: _limit, offset: _offset)) {
          accumulated = [...accumulated, ...newPokemons];
          hasReachedMax = newPokemons.length < _limit;

          emit(PokemonListData(pokemons: accumulated, isRefreshing: true, hasReachedMax: hasReachedMax));
        }
        _offset += accumulated.length;

        emit(PokemonListData(pokemons: accumulated, isRefreshing: false, hasReachedMax: hasReachedMax));
      } catch (_) {
        emit(PokemonListData(pokemons: accumulated, isRefreshing: false, hasReachedMax: hasReachedMax));

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
}
