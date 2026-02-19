import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_detail.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetail getPokemonDetail;

  PokemonDetailCubit({required this.getPokemonDetail}) : super(PokemonDetailInitial());

  Future<void> fetch(int id) {
    return _execute(() async {
      emit(PokemonDetailLoading());

      final pokemonDetail = await getPokemonDetail(id);

      emit(PokemonDetailData(pokemonDetail: pokemonDetail));
    });
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
