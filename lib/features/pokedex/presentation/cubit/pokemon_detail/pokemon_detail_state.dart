part of 'pokemon_detail_cubit.dart';

sealed class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailData extends PokemonDetailState {
  final PokemonDetail pokemonDetail;

  PokemonDetailData({required this.pokemonDetail});
}

class PokemonDetailError extends PokemonDetailState {
  final String message;

  PokemonDetailError({required this.message});
}
