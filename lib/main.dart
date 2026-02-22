import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter_offline_web/core/di/app_injection.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/screens/pokedex_shell_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(PokedexApp(injection: AppInjection()));
}

class PokedexApp extends StatefulWidget {
  final AppInjection injection;

  const PokedexApp({super.key, required this.injection});

  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  void dispose() {
    unawaited(widget.injection.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonListCubit>.value(value: widget.injection.pokedexModule.pokemonListCubit),
        BlocProvider<PokemonDetailCubit>.value(value: widget.injection.pokedexModule.pokemonDetailCubit),
      ],
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: PokedexShellScreen()),
    );
  }
}
