import 'package:elementary/elementary.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';

/// Model for [HotelScreen].
class HotelScreenModel extends ElementaryModel implements IHotelScreenModel {
  final Environment _environment;
  final IThemeService _themeService;

  @override
  bool get isDebugMode => !_environment.isRelease;

  /// Create an instance [HotelScreenModel].
  HotelScreenModel(this._environment, this._themeService);

  @override
  void switchTheme() {
    _themeService.switchTheme();
  }
}

/// Interface of [HotelScreenModel].
abstract class IHotelScreenModel extends ElementaryModel {
  /// Return value for app environment status.
  bool get isDebugMode;

  /// Switch theme mode between light and dark.
  void switchTheme();
}
