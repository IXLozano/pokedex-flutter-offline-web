import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _source;

  PokemonRepositoryImpl({required PokemonRemoteDataSource source}) : _source = source;

  @override
  Stream<List<Pokemon>> watchPokemonPage({required int limit, required int offset}) async* {
    final remotePokemons = await _execute(
      () => _source
          .fetchPokemonPage(limit: limit, offset: offset)
          .then((response) => response.results.map((e) => e.toEntity()).toList()),
    );

    final mergedPokemons = _mergePokemonsById(const <Pokemon>[], remotePokemons);

    yield mergedPokemons;
  }

  @override
  Stream<PokemonDetail> watchPokemonDetail(int id) async* {
    yield await _execute(
      () => _source
          .fetchPokemonDetail(id) //
          .then((response) => response.toEntity()),
    );
  }

  List<Pokemon> _mergePokemonsById(List<Pokemon> existing, List<Pokemon> incoming) {
    final map = <int, Pokemon>{for (final p in existing) p.id: p};
    for (final p in incoming) {
      map[p.id] = p;
    }
    return map.values.toList()..sort((a, b) => a.id.compareTo(b.id));
  }

  Future<T> _execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } on ParsingException catch (e) {
      throw UnknownFailure(e.message);
    } catch (_) {
      throw UnknownFailure('Unexpected error');
    }
  }
}
