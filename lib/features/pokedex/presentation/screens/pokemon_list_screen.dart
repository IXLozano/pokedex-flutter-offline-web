import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:shimmer/shimmer.dart';

class PokemonListScreen extends StatefulWidget {
  final void Function(int id)? onPokemonTap;

  const PokemonListScreen({super.key, this.onPokemonTap});

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
  void dispose() {
    _scrollController.removeListener(_handleController);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return switch (state) {
            PokemonListInitial() => const SizedBox.shrink(),
            PokemonListLoading() => const Center(child: CircularProgressIndicator()),
            PokemonListError(:final message) => Center(child: Text(message)),
            PokemonListData(:final pokemons, :final isRefreshing) => _ListView(
              scrollController: _scrollController,
              pokemons: pokemons,
              widget: widget,
              isRefreshing: isRefreshing,
            ),
          };
        },
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    required ScrollController scrollController,
    required this.pokemons,
    required this.widget,
    required this.isRefreshing,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Pokemon> pokemons;
  final PokemonListScreen widget;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];

            return ListTile(
              onTap: () => widget.onPokemonTap?.call(pokemon.id),
              title: Text(pokemon.name.toUpperCase()),
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
                          child: Container(color: Color(0xFFCBD5E1)),
                        );
                      }

                      return child;
                    },
                    errorBuilder: (_, _, _) => const Icon(Icons.catching_pokemon, size: 40),
                  ),
                ),
              ),
            );
          },
        ),

        if (isRefreshing)
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))),
          ),
      ],
    );
  }
}
