import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_model.dart';
import 'package:provider/provider.dart';

/// Factory for [HotelScreenWidgetModel].
HotelScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HotelScreenModel(
    Environment.instance(),
    appScope.themeService,
  );

  return HotelScreenWidgetModel(model);
}

/// Widget model for [HotelScreen].
class HotelScreenWidgetModel extends WidgetModel<HotelScreen, IHotelScreenModel>
    with ThemeWMMixin
    implements IDebugWidgetModel {
  /*final _defaultNavBarItems = [
    const BottomNavigationBarItem(
      label: 'Dash screen',
      icon: Icon(Icons.flutter_dash),
    ),
    const BottomNavigationBarItem(
      label: 'Info screen',
      icon: Icon(Icons.info_outline),
    ),
  ];*/

 /* final _debugNavBarItem = const BottomNavigationBarItem(
    label: 'Debug screen',
    icon: Icon(Icons.bug_report_outlined),
  );
*/
  @override
  List<PageRouteInfo> get routes => _routes;

 /* @override
  List<BottomNavigationBarItem> get navigationBarItems => _navigationBarItems;
*/
  List<PageRouteInfo> get _routes {
    final defaultRoutes = <PageRouteInfo>[DashRouter(), InfoRouter()];
    if (_isDebugMode) defaultRoutes.add(DebugRouter());
    return defaultRoutes;
  }

  /*List<BottomNavigationBarItem> get _navigationBarItems {
    final navBarItems = [..._defaultNavBarItems];
    if (_isDebugMode) navBarItems.add(_debugNavBarItem);
    return navBarItems;
  }*/

  bool get _isDebugMode => model.isDebugMode;

  /// Create an instance [HotelScreenWidgetModel].
  HotelScreenWidgetModel(super._model);

 /* @override
  String appBarTitle(RouteData topRoute) => _appBarTitle(topRoute);
*/
  @override
  void switchTheme() => model.switchTheme();

  /*String _appBarTitle(RouteData topRoute) {
    switch (topRoute.path) {
      case AppRoutePaths.debugPath:
        return 'Экран отладки';
      case AppRoutePaths.dashPath:
        return 'Отель';
      case AppRoutePaths.infoPath:
        return 'Info';
      default:
        return '';
    }
  }*/
}

/// Interface of [HotelScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Routes for [AutoTabsRouter.tabBar].
  /*List<PageRouteInfo<dynamic>> get routes;*/

  /*/// Items for [BottomNavigationBar].
  List<BottomNavigationBarItem> get navigationBarItems;
*/
 /* /// Title for appbar, depends on current selected page.
  String appBarTitle(RouteData topRoute);
*/
  /// Switch theme mode between light and dark.
  void switchTheme();
}
