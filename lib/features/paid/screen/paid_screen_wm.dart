import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/common/utils/analytics/service/analytics_service.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/paid/screen/paid_screen.dart';
import 'package:flutter_template/features/paid/screen/paid_screen_model.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:provider/provider.dart';

/// Factory for [PaidScreenWidgetModel].
PaidScreenWidgetModel paidScreenWmFactory(
  BuildContext context,
) {
  final scope = context.read<IAppScope>();
  final model = PaidScreenModel();
  final router = scope.router;
  return PaidScreenWidgetModel(
    model: model,
    analyticsService: scope.analyticsService,
    router,
  );
}

/// Widget model for [PaidScreen].
class PaidScreenWidgetModel extends WidgetModel<PaidScreen, PaidScreenModel> with ThemeWMMixin implements IPaidScreenWidgetModel {
  final IAnalyticsService _analyticsService;
  final AppRouter router;

  @override
  AppLocalizations get l10n => context.l10n;

  /// Create an instance [PaidScreenWidgetModel].
  PaidScreenWidgetModel(
    this.router, {
    required PaidScreenModel model,
    required IAnalyticsService analyticsService,
  })  : _analyticsService = analyticsService,
        super(model);

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void openNextScreen() {
    router.push(HotelRouter());
  }
}

/// Interface of [IPaidScreenWidgetModel].
abstract class IPaidScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Localization strings.
  AppLocalizations get l10n;

  /// Method to close the paid screens.
  void closeScreen() {}

  /// Navigate to booking screen.
  void openNextScreen();
}
