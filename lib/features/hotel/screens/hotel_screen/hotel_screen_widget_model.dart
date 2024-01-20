import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [HotelScreenWidgetModel].
HotelScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HotelScreenModel();

  return HotelScreenWidgetModel(
    model,
    appScope.router,
  );
}

/// Widget model for [HotelScreen].
class HotelScreenWidgetModel extends WidgetModel<HotelScreen, IHotelScreenModel> with ThemeWMMixin implements IHotelWidgetModel {
  final AppRouter _appRouter;

  /// Create an instance [HotelScreenWidgetModel].
  HotelScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  @override
  void openNextScreen() {
    _appRouter.push(RoomRouter());
  }
}

/// Interface of [HotelScreenWidgetModel].
abstract class IHotelWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Navigate to room screen.
  void openNextScreen();
}
