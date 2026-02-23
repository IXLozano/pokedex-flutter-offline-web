import 'package:pokedex_flutter_offline_web/core/network/dio_client.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/data/datasources/local/pokedex_database.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/di/pokedex_module.dart';

/// Root dependency container that wires shared app-level services.
class AppInjection {
  late final DioClient _dioClient;
  late final PokedexDatabase _db;

  late final PokedexModule pokedexModule;

  AppInjection() {
    _dioClient = DioClient();
    _db = PokedexDatabase();
    pokedexModule = PokedexModule(dio: _dioClient.dio, db: _db);
  }

  /// Releases app-level resources that require explicit shutdown.
  Future<void> dispose() async {
    await _db.close();
  }
}
