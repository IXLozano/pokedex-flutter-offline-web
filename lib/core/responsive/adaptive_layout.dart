import 'package:flutter/widgets.dart';
import 'package:pokedex_flutter_offline_web/core/responsive/breakpoints.dart';

class AdaptiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const AdaptiveLayout({super.key, required this.mobile, this.tablet, required this.desktop});

  @override
  Widget build(BuildContext context) {
    final size = Breakpoints.fromWidth(MediaQuery.of(context).size.width);

    return switch (size) {
      ScreenSize.mobile => mobile,
      ScreenSize.tablet => tablet ?? desktop,
      ScreenSize.desktop => desktop,
    };
  }
}
