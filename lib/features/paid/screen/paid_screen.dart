import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/paid/screen/paid_screen_widget_model.dart';
/// Main widget for PaidScreen feature.
@RoutePage(
  name: AppRouteNames.paidScreen,
)
class PaidScreen extends ElementaryWidget<IPaidScreenWidgetModel> {
  /// Create an instance [PaidScreen].
  const PaidScreen({
    Key? key,
    WidgetModelFactory wmFactory = paidScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPaidScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            InkWell(
                splashColor: Colors.transparent, highlightColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.iconBackArrow)),
            const Spacer(),
            Text('Заказ оплачен', style: AppTextStyle.medium18.value.copyWith(color: AppColors.black)),
            const Spacer(),
          ],
        ),
      ),
      body: _Body(openNextScreen: wm.openNextScreen),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;

  const _Body({
    required this.openNextScreen,
  });

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Image.asset(Images.paid),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 32),
            child: Text('Ваш заказ принят в работу', style: AppTextStyle.medium18.value),
          ),
          Text(
            'Подтверждение заказа №${rng.nextInt(100)} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на'
                ' почту придет уведомление.',
            style: AppTextStyle.medium18.value.copyWith(color: AppColors.gray),
            textAlign: TextAlign.center,
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppButtonWidget(
              title: 'Выбрать номер',
              onPressed: openNextScreen,
            ),
          ),
        ],
      ),
    );
  }
}
