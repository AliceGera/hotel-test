import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/common/utils/analytics/event/common/track_analytics_example.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/room/screen/room_screen.dart';
import 'package:flutter_template/features/room/screen/room_screen_model.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';
import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';

/// Factory for [RoomScreenWidgetModel].
RoomScreenWidgetModel roomScreenWmFactory(
  BuildContext context,
) {
  final scope = context.read<IAppScope>();
  final model = RoomScreenModel(scope.roomsService);
  final router = scope.router;
  return RoomScreenWidgetModel(
    model: model,
    analyticsService: scope.analyticsService,
    router,
  );
}

/// Widget model for [RoomScreen].
class RoomScreenWidgetModel extends WidgetModel<RoomScreen, RoomScreenModel> with ThemeWMMixin implements IRoomScreenWidgetModel {
  final IAnalyticsService _analyticsService;
  final AppRouter router;

  @override
  AppLocalizations get l10n => context.l10n;

  /// Create an instance [RoomScreenWidgetModel].
  RoomScreenWidgetModel(
    this.router, {
    required RoomScreenModel model,
    required IAnalyticsService analyticsService,
  })  : _analyticsService = analyticsService,
        super(model);

  final _roomsState = UnionStateNotifier<Rooms>(Rooms.init());

  late final Rooms rooms;

  @override
  void initWidgetModel() {
    _getRooms();
    super.initWidgetModel();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void trackAnalyticsExample() {
    _analyticsService.trackEvent(const TrackAnalyticsExampleEvent());
  }

  @override
  void openNextScreen() {
    router.push(BookingRouter());
  }

  Future<void> _getRooms() async {
    _roomsState.loading();
    try {
      rooms = (await model.getRooms())!;
      _roomsState.content(rooms);
      await Future.delayed( const Duration(milliseconds: 100));
    } catch (_) {
      _roomsState.failure();
    }
  }

  @override
  void loadAgain() {
    _getRooms();
  }

  @override
  UnionStateNotifier<Rooms> get RoomsState => _roomsState;
}

/// Interface of [IRoomScreenWidgetModel].
abstract class IRoomScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Localization strings.
  AppLocalizations get l10n;

  /// Method to close the room screens.
  void closeScreen() {}

  /// Sending an analytics event
  void trackAnalyticsExample();

  /// Navigate to booking screen.
  void openNextScreen();

  /// Method to load again room screen.
  void loadAgain(){}

  UnionStateNotifier<Rooms> get RoomsState;
}
