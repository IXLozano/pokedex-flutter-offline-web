import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';

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
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  fit: BoxFit.contain,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  memCacheWidth: 96,
                  maxWidthDiskCache: 96,
                  placeholder: (_, _) => const Icon(Icons.catching_pokemon, size: 40),
                  errorWidget: (_, _, _) => const Icon(Icons.catching_pokemon, size: 40),
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
