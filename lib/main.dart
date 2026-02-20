import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/di/app_injection.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokemon_list_screen.dart';

void main() => runApp(PokedexApp(injection: AppInjection()));

class PokedexApp extends StatelessWidget {
  final AppInjection injection;

  const PokedexApp({super.key, required this.injection});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonListCubit>.value(value: injection.pokedexModule.pokemonListCubit),
        BlocProvider<PokemonDetailCubit>.value(value: injection.pokedexModule.pokemonDetailCubit),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: PokemonListScreen()),
    );
  }
}
