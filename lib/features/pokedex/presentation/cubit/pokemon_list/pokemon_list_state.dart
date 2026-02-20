part of 'pokemon_list_cubit.dart';

sealed class PokemonListState {}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListData extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool isRefreshing;
  final bool hasReachedMax;

  PokemonListData({required this.pokemons, this.isRefreshing = false, this.hasReachedMax = false});

  PokemonListData copyWith({List<Pokemon>? pokemons, bool? isRefreshing, bool? hasReachedMax}) {
    return PokemonListData(
      pokemons: pokemons ?? this.pokemons,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError({required this.message});
}
