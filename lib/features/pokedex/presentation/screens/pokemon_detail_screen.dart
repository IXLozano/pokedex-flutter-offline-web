import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:shimmer/shimmer.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonDetailCubit>().fetch(widget.pokemonId);
  }

  @override
  void didUpdateWidget(covariant PokemonDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pokemonId != widget.pokemonId) context.read<PokemonDetailCubit>().fetch(widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          return switch (state) {
            PokemonDetailInitial() => SizedBox.shrink(),
            PokemonDetailLoading() => Center(child: CircularProgressIndicator()),
            PokemonDetailError(:final message) => Center(child: Text(message)),
            PokemonDetailData(:final pokemonDetail) => _DetailView(pokemonDetail: pokemonDetail),
          };
        },
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  final PokemonDetail pokemonDetail;
  const _DetailView({required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.network(
                  pokemonDetail.imageUrl,
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
                  errorBuilder: (_, _, _) => const Icon(Icons.catching_pokemon, size: 100),
                ),
              ),

              const SizedBox(height: 24),

              Text(pokemonDetail.name.toUpperCase(), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

              const SizedBox(height: 16),

              Text('Height: ${pokemonDetail.height}'),
              Text('Weight: ${pokemonDetail.weight}'),

              const SizedBox(height: 24),

              Wrap(spacing: 8, children: pokemonDetail.types.map((t) => Chip(label: Text(t))).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
