import 'package:dio/dio.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/remote/pokemon_remote_datasource.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/exceptions/exceptions.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_detail_dto.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/models/pokemon_list_response_dto.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio _dio;

  PokemonRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<PokemonListResponseDto> getPokemonPage({required int limit, required int offset}) => //
  _execute(
    () => _dio
        .get('pokemon', queryParameters: {'limit': limit, 'offset': offset})
        .then((response) => PokemonListResponseDto.fromJson(response.data as Map<String, dynamic>)),
  );

  @override
  Future<PokemonDetailDto> getPokemonDetail(int id) => //
  _execute(
    () => _dio
        .get('pokemon/$id') //
        .then((response) => PokemonDetailDto.fromJson(response.data as Map<String, dynamic>)),
  );

  Future<T> _execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError ||
        DioExceptionType.cancel ||
        DioExceptionType.badCertificate ||
        DioExceptionType.unknown => NetworkException(message: 'Network error'),

        _ => ServerException(message: e.message ?? 'Server error', statusCode: e.response?.statusCode),
      };
    } catch (e) {
      throw ParsingException(message: 'Invalid response: ${e.toString()}');
    }
  }
}
