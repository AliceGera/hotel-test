import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/rooms/room_data.dart';
import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';
import 'package:flutter_template/features/common/extension/string_extension.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_gallery_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/room/screen/room_screen_widget_model.dart';
import 'package:union_state/union_state.dart';

/// Main widget for RoomScreen feature.
@RoutePage(
  name: AppRouteNames.roomScreen,
)
class RoomScreen extends ElementaryWidget<IRoomScreenWidgetModel> {
  /// Create an instance [RoomScreen].
  const RoomScreen({
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
      body: _Body(openNextScreen: wm.openNextScreen, roomsState: wm.RoomsState),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;
  final UnionStateNotifier<Rooms> roomsState;

  const _Body({
    required this.openNextScreen,
    required this.roomsState,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<Rooms>(
        unionStateListenable: roomsState,
        builder: (_, rooms) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rooms.rooms.length,
                  itemBuilder: (context, index) {
                    return _RoomWidget(openNextScreen: openNextScreen, room: rooms.rooms[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ],
            ),
          );
        },
        loadingBuilder: (_, rooms) => SizedBox(),
        failureBuilder: (_, exception, rooms) => SizedBox());
  }
}

class _RoomWidget extends StatelessWidget {
  final VoidCallback openNextScreen;
  final Room room;

  const _RoomWidget({
    required this.openNextScreen,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGalleryWidget(imageUrls: room.imageUrls),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                room.name,
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...room.peculiarities.map(
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
                    '${room.price.toString().spaceSeparateNumbers()} ₽',
                    style: AppTextStyle.semiBold30.value.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(width: 8),
                  Text(room.pricePer, style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray)),
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
