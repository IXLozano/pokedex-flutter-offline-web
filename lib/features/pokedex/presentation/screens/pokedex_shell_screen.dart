import 'package:flutter/widgets.dart';
import 'package:pokedex_flutter_offline_web/core/responsive/adaptive_layout.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/layouts/pokedex_desktop_layout.dart';
import 'package:pokedex_flutter_offline_web/features/pokedex/presentation/layouts/pokedex_mobile_layout.dart';

/// Responsive shell that picks mobile or desktop pokedex layout.
class PokedexShellScreen extends StatelessWidget {
  const PokedexShellScreen({super.key});

  /// Builds the adaptive container for the current screen width.
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(mobile: PokedexMobileLayout(), desktop: PokedexDesktopLayout());
  }
}
