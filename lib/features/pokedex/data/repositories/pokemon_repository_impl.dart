import 'package:pokedex_flutter_offline_web/core/error/failures.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/mappers/pokemon_mapper.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoriesImpl implements PokemonRepository {
  final PokemonRemoteDataSource _source;

  PokemonRepositoriesImpl({required PokemonRemoteDataSource source}) : _source = source;

  @override
  Future<List<Pokemon>> getPokemonPage({int limit = 20, int offset = 0}) => _execute(
    () async => await _source
        .getPokemonPage(limit: limit, offset: offset)
        .then((response) => response.results.map((e) => e.toEntity()).toList()),
  );

  @override
  Future<PokemonDetail> getPokemonDetail(int id) =>
      _execute(() async => await _source.getPokemonDetail(id).then((response) => response.toEntity()));

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
