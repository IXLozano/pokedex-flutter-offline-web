import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:shimmer/shimmer.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<PokemonListCubit>().fetchInitial();

    _scrollController.addListener(_handleController);
  }

  void _handleController() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 400) {
      context.read<PokemonListCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return switch (state) {
            PokemonListInitial() => const SizedBox(),
            PokemonListLoading() => const Center(child: CircularProgressIndicator()),
            PokemonListError(:final message) => Center(child: Text(message)),
            PokemonListData(:final pokemons, :final isRefreshing) => Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];

                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.contain,
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;

                              if (frame == null) {
                                return Shimmer.fromColors(
                                  baseColor: const Color(0xFFCBD5E1),
                                  highlightColor: const Color(0xFFF8FAFC),
                                  period: const Duration(milliseconds: 1200),
                                  child: Container(color: const Color(0xFFCBD5E1)),
                                );
                              }

                              return child;
                            },
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, size: 40),
                          ),
                        ),
                      ),
                      title: Text(pokemon.name),
                    );
                  },
                ),

                if (isRefreshing)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 24,
                    child: Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                  ),
              ],
            ),
          };
        },
      ),
    );
  }
}
