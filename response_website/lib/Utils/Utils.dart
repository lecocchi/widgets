class Utils {
  static bool isDesktop(double width) {
    return width >= 1200;
  }

  static bool isTablet(double width) {
    return (width > 800 && width < 1200);
  }

  static bool isMobile(double width) {
    return width <= 800;
  }
}
