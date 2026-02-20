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
      await Future.delayed(const Duration(seconds: 2));
      final pokemons = await getPokemonPage(limit: _limit, offset: 0);

      _offset = _limit;

      emit(PokemonListData(pokemons: pokemons));
    });
  }

  Future<void> fetchNextPage() {
    if (_isFetching) return Future.value();

    return _execute(() async {
      final currentState = state;

      if (currentState is! PokemonListData) return;

      _isFetching = true;

      emit(currentState.copyWith(isRefreshing: true));

      try {
        await Future.delayed(const Duration(seconds: 0));

        final newPokemons = await getPokemonPage(limit: _limit, offset: _offset);

        _offset += _limit;

        emit(PokemonListData(pokemons: [...currentState.pokemons, ...newPokemons], isRefreshing: false));
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
}
