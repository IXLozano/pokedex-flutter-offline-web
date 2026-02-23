part of 'pokemon_list_cubit.dart';

/// Base state contract for pokemon list UI state transitions.
sealed class PokemonListState {}

/// Initial idle state before the first fetch starts.
class PokemonListInitial extends PokemonListState {}

/// Blocking loading state used for first-screen bootstrap.
class PokemonListLoading extends PokemonListState {}

/// Empty state shown when no list data is available.
class PokemonListEmpty extends PokemonListState {}

/// Data state containing current list content and pagination flags.
class PokemonListData extends PokemonListState {
  final List<Pokemon> pokemons;
  final bool isRefreshing;
  final bool hasReachedMax;

  PokemonListData({required this.pokemons, this.isRefreshing = false, this.hasReachedMax = false});

  /// Creates a new data state by replacing selected fields.
  PokemonListData copyWith({List<Pokemon>? pokemons, bool? isRefreshing, bool? hasReachedMax}) {
    return PokemonListData(
      pokemons: pokemons ?? this.pokemons,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

/// Error state used for blocking list failures.
class PokemonListError extends PokemonListState {
  final String message;

  PokemonListError({required this.message});
}
