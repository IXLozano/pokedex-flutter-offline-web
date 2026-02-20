import 'package:flutter/material.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokemon_list_screen.dart';

class PokedexDesktopLayout extends StatefulWidget {
  const PokedexDesktopLayout({super.key});

  @override
  State<PokedexDesktopLayout> createState() => _PokedexDesktopLayoutState();
}

class _PokedexDesktopLayoutState extends State<PokedexDesktopLayout> {
  int? _selectedPokemonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 350, child: PokemonListScreen(onPokemonTap: (id) => setState(() => _selectedPokemonId = id))),
          const VerticalDivider(width: 1),
          Expanded(
            child: _selectedPokemonId == null
                ? const _PlaceHolderDetail()
                : PokemonDetailScreen(pokemonId: _selectedPokemonId!),
          ),
        ],
      ),
    );
  }
}

class _PlaceHolderDetail extends StatelessWidget {
  const _PlaceHolderDetail();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.catching_pokemon, size: 120, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text('Select a Pokemon', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
