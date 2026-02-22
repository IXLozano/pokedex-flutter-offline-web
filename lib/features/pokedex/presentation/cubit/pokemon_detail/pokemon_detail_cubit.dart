import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_detail.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;
  StreamSubscription<PokemonDetail>? _detailSubscription;

  PokemonDetailCubit({required this.getPokemonDetail}) : super(PokemonDetailInitial());

  Future<void> fetch(int id) {
    return _execute(() async {
      emit(PokemonDetailLoading());

      await _detailSubscription?.cancel();

      _detailSubscription = getPokemonDetail(id).listen(
        (pokemonDetail) {
          emit(PokemonDetailData(pokemonDetail: pokemonDetail));
        },
        onError: (e) {
          if (e is Failure) {
            emit(PokemonDetailError(message: e.message));
          } else {
            emit(PokemonDetailError(message: 'Unexpected error: ${e.toString()}'));
          }
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _detailSubscription?.cancel();
    return super.close();
  }

  Future<void> _execute(Future<void> Function() action) async {
    try {
      return await action();
    } on Failure catch (f) {
      emit(PokemonDetailError(message: f.message));
    } catch (f) {
      emit(PokemonDetailError(message: 'Unexpected error: ${f.toString()}'));
    }
  }
}
