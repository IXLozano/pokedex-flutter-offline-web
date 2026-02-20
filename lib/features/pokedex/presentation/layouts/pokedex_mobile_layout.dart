import 'package:flutter/material.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokemon_list_screen.dart';

class PokedexMobileLayout extends StatelessWidget {
  const PokedexMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return PokemonListScreen(
      onPokemonTap: (id) =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemonId: id))),
    );
  }
}
