import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/booking/screen/booking_screen.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_model.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [BookingScreenWidgetModel].
BookingScreenWidgetModel bookingScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = BookingScreenModel(appScope.bookingService);
  return BookingScreenWidgetModel(
    model,
    appScope.router,
  );
}

/// Widget model for [BookingScreen].
class BookingScreenWidgetModel extends WidgetModel<BookingScreen, BookingScreenModel> with ThemeWMMixin implements IBookingWidgetModel {
  final AppRouter _appRouter;

  /// Create an instance [BookingScreenWidgetModel].
  BookingScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  final _bookingState = UnionStateNotifier<Booking>(Booking.init());
  late final Booking booking;

  @override
  void initWidgetModel() {
    _getBooking();
    super.initWidgetModel();
  }

  @override
  void openNextScreen() {
    _appRouter.push(PaidRouter());
  }

  @override
  void closeScreen() {
    _appRouter.pop();
  }

  Future<void> _getBooking() async {
    _bookingState.loading();
    try {
      booking = (await model.getBooking())!;
      _bookingState.content(booking);
    } catch (_) {
      _bookingState.failure();
    }
  }

  @override
  UnionStateNotifier<Booking> get BookingState => _bookingState;
}

/// Interface of [BookingScreenWidgetModel].
abstract class IBookingWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Navigate to room screen.
  void openNextScreen();

  /// Method to close the booking screens.
  void closeScreen() {}

  UnionStateNotifier<Booking> get BookingState;
}
