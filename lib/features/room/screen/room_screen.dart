import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/room/screen/room_screen_wm.dart';

/// Main widget for RoomScreen feature.
@RoutePage(
  name: AppRouteNames.roomScreen,
)
class RoomScreen extends ElementaryWidget<IRoomScreenWidgetModel> {
  /// Create an instance [RoomScreen].
  RoomScreen({
    Key? key,
    WidgetModelFactory wmFactory = roomScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IRoomScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            InkWell(
                splashColor: Colors.transparent, highlightColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.iconBackArrow)),
            const Spacer(),
            Text('Steigenberger Makadi', style: AppTextStyle.medium18.value.copyWith(color: AppColors.black)),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _RoomWidget(openNextScreen: openNextScreen);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ],
      ),
    );
  }
}

class _RoomWidget extends StatelessWidget {
  final controller = PageController();
  final VoidCallback openNextScreen;

  _RoomWidget({
    required this.openNextScreen,
  });

  List<String> infoAboutRoomList = [
    'Все включено',
    'Кондиционер',
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: PageView(
                controller: controller,
                children: <Widget>[
                  Image.asset('assets/images/hotel.png'),
                  Image.asset('assets/images/hotel.png'),
                  Image.asset('assets/images/hotel.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Стандартный с видом на бассейн или сад',
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...infoAboutRoomList.map(
                    (e) => DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.lightGray, borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(e, style: AppTextStyle.medium16.value.copyWith(color: AppColors.gray)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          'Подробнее о номере',
                          style: AppTextStyle.medium16.value.copyWith(color: AppColors.blue),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: SvgPicture.asset(SvgIcons.iconMoreAboutRoomArrow),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '186 600 ₽',
                    style: AppTextStyle.semiBold30.value.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(width: 8),
                  Text('за тур с перелётом', style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray)),
                ],
              ),
            ),
            AppButtonWidget(
              title: 'Выбрать номер',
              onPressed: openNextScreen,
            ),
          ],
        ),
      ),
    );
  }
}
