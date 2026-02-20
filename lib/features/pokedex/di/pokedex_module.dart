import 'package:dio/dio.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource_impl.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/usecases/get_pokemon_page.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_detail/pokemon_detail_cubit.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/cubit/pokemon_list/pokemon_list_cubit.dart';

class PokedexModule {
  late final PokemonListCubit pokemonListCubit;
  late final PokemonDetailCubit pokemonDetailCubit;

  PokedexModule({required Dio dio}) {
    final remoteDataSource = PokemonRemoteDataSourceImpl(dio: dio);
    final repository = PokemonRepositoryImpl(source: remoteDataSource);
    final getPokemonPage = GetPokemonPage(repository: repository);
    final getPokemonDetail = GetPokemonDetail(repository: repository);

    pokemonListCubit = PokemonListCubit(getPokemonPage: getPokemonPage);
    pokemonDetailCubit = PokemonDetailCubit(getPokemonDetail: getPokemonDetail);
  }
}
