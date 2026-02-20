enum ScreenSize { mobile, tablet, desktop }

class Breakpoints {
  static ScreenSize fromWidth(double width) {
    if (width < 600) return ScreenSize.mobile;
    if (width < 1024) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }
}
