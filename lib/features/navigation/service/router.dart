import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/hotel/hotel_routes.dart';
import 'package:flutter_template/features/navigation/domain/entity/room/room_routes.dart';
import 'package:flutter_template/features/room/screen/room_screen_export.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_export.dart';
import 'package:flutter_template/features/navigation/domain/entity/booking/booking_routes.dart';

part 'router.gr.dart';

/// When you add route with screen don't forget add imports of screen and screen_widget_model

@AutoRouterConfig(
  replaceInRouteName: 'ScreenWidget|Screen,Route',
)

/// Main point of the application navigation.
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        hotelRoutes,
        /*logHistoryRoutes,
        uiKitRoutes,*/
    //dashRoutes,
        roomRoutes,
        bookingRoutes,
      ];

  AppRouter._();

  /// Singleton instance of [AppRouter].
  factory AppRouter.instance() => _router;
}
