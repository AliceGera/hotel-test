import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_paths.dart';
import 'package:flutter_template/features/navigation/service/router.dart';

/// Route for the paid screen.
final paidRoutes = AutoRoute(
  page: PaidRouter.page,
  path: AppRoutePaths.paidPath,
);
