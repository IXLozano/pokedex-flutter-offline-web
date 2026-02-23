part of 'pokemon_detail_cubit.dart';

/// Base state contract for pokemon detail UI transitions.
sealed class PokemonDetailState {}

/// Initial idle state before requesting detail data.
class PokemonDetailInitial extends PokemonDetailState {}

/// Blocking loading state for detail bootstrap.
class PokemonDetailLoading extends PokemonDetailState {}

/// Data state containing a fully mapped pokemon detail entity.
class PokemonDetailData extends PokemonDetailState {
  final PokemonDetail pokemonDetail;

  PokemonDetailData({required this.pokemonDetail});
}

/// Error state used when detail data cannot be loaded.
class PokemonDetailError extends PokemonDetailState {
  final String message;

  PokemonDetailError({required this.message});
}
