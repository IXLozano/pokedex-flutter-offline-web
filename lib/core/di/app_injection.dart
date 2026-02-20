import 'package:pokedex_flutter_offline_web/core/network/dio_client.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/di/pokedex_module.dart';

class AppInjection {
  late final DioClient _dioClient;
  late final PokedexModule pokedexModule;

  AppInjection() {
    _dioClient = DioClient();

    pokedexModule = PokedexModule(dio: _dioClient.dio);
  }
}
