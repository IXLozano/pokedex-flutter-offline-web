part of 'pokemon_list_cubit.dart';

sealed class PokemonListState {}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListData extends PokemonListState {
  final List<Pokemon> pokemons;

  PokemonListData({required this.pokemons});
}

class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError({required this.message});
}
