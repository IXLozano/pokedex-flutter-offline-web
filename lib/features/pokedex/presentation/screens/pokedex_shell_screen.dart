import 'package:flutter/widgets.dart';
import 'package:pokedex_flutter_offline_web/core/responsive/adaptive_layout.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/layouts/pokedex_desktop_layout.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/layouts/pokedex_mobile_layout.dart';

class PokedexShellScreen extends StatelessWidget {
  const PokedexShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(mobile: PokedexMobileLayout(), desktop: PokedexDesktopLayout());
  }
}
