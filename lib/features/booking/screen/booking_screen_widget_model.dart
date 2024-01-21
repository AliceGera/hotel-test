import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_template/features/booking/screen/booking_screen.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_model.dart';

/// Factory for [BookingScreenWidgetModel].
BookingScreenWidgetModel bookingScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = BookingScreenModel();

  return BookingScreenWidgetModel(
    model,
    appScope.router,
  );
}

/// Widget model for [BookingScreen].
class BookingScreenWidgetModel extends WidgetModel<BookingScreen, IBookingScreenModel> with ThemeWMMixin implements IBookingWidgetModel {
  final AppRouter _appRouter;

  /// Create an instance [BookingScreenWidgetModel].
  BookingScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  @override
  void openNextScreen() {
    _appRouter.push(RoomRouter());
  }

  @override
  void closeScreen() {
    _appRouter.pop();
  }
}

/// Interface of [BookingScreenWidgetModel].
abstract class IBookingWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Navigate to room screen.
  void openNextScreen();

  /// Method to close the booking screens.
  void closeScreen() {}
}
