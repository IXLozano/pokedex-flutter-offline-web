import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final GetPokemonPage getPokemonPage;

  final int _limit = 20;
  bool _isFetching = false;

  PokemonListCubit({required this.getPokemonPage}) : super(PokemonListInitial());

  Future<void> fetchInitial() {
    return _execute(() async {
      emit(PokemonListLoading());

      _isFetching = false;

      final pokemons = await _resolvePage(limit: _limit, offset: 0);

      if (pokemons.isEmpty) {
        emit(PokemonListError(message: 'No cached data and no network response.'));
        return;
      }

      emit(PokemonListData(pokemons: pokemons, hasReachedMax: pokemons.length < _limit));
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
        List<Pokemon> newPokemons = await _resolvePage(limit: _limit, offset: offset);

        if (newPokemons.isEmpty) {
          emit(currentState.copyWith(isRefreshing: false));
          return;
        }

        bool hasReachedMax = newPokemons.length < _limit;
        List<Pokemon> accumulated = [...currentState.pokemons, ...newPokemons];

        emit(PokemonListData(pokemons: accumulated, isRefreshing: false, hasReachedMax: hasReachedMax));
      } catch (_) {
        emit(currentState.copyWith(isRefreshing: false));
        rethrow;
      } finally {
        _isFetching = false;
      }
    });
  }

  Future<List<Pokemon>> _resolvePage({required int limit, required int offset}) async {
    final stream = getPokemonPage(limit: limit, offset: offset).asBroadcastStream();

    final firstEmission = await stream.first;
    if (firstEmission.isNotEmpty) return firstEmission;

    try {
      return await stream
          .firstWhere((page) => page.isNotEmpty)
          .timeout(const Duration(seconds: 5), onTimeout: () => firstEmission);
    } catch (_) {
      return firstEmission;
    }
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
