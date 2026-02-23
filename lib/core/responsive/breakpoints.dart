enum ScreenSize { mobile, tablet, desktop }

/// Resolves a semantic screen size based on the current viewport width.
class Breakpoints {
  /// Maps raw width to app breakpoints used by responsive layouts.
  static ScreenSize fromWidth(double width) {
    if (width < 600) return ScreenSize.mobile;
    if (width < 1024) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }
}
