import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [HotelScreenWidgetModel].
HotelScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HotelScreenModel(appScope.hotelService);

  return HotelScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HotelScreen].
class HotelScreenWidgetModel extends WidgetModel<HotelScreen, HotelScreenModel> with ThemeWMMixin implements IHotelWidgetModel {
  final AppRouter _appRouter;

  /// Create an instance [HotelScreenWidgetModel].
  HotelScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  final _hotelState = UnionStateNotifier<Hotel>(Hotel.init());

  late final Hotel hotel;

  @override
  void initWidgetModel() {
    _getHotel();
    super.initWidgetModel();
  }

  @override
  void openNextScreen() {
    _appRouter.push(RoomRouter(hotelName: hotel.name));
  }

  Future<void> _getHotel() async {
    _hotelState.loading();
    try {
      hotel = (await model.getHotel())!;
      await Future.delayed(const Duration(milliseconds: 100));
      _hotelState.content(hotel);
    } catch (_) {
      _hotelState.failure();
    }
  }

  @override
  void loadAgain() {
    _getHotel();
  }

  @override
  UnionStateNotifier<Hotel> get HotelState => _hotelState;
}

/// Interface of [HotelScreenWidgetModel].
abstract class IHotelWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Navigate to room screen.
  void openNextScreen();

  /// Method to load again hotel screen.
  void loadAgain(){}

  UnionStateNotifier<Hotel> get HotelState;
}
