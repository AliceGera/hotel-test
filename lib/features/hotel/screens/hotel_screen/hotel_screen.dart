import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';
import 'package:flutter_template/features/common/extension/string_extension.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/common/widgets/app_gallery_widget.dart';
import 'package:flutter_template/features/common/widgets/app_rating_widget.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_widget_model.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/widgets/hotel_loading_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
@RoutePage(
  name: AppRouteNames.hotelScreen,
)
class HotelScreen extends ElementaryWidget<HotelScreenWidgetModel> {
  /// Create an instance [HotelScreen].

  const HotelScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(HotelScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Center(
          child: Text('Отель', style: AppTextStyle.medium18.value.copyWith(color: AppColors.black)),
        ),
      ),
      body: _Body(openNextScreen: wm.openNextScreen, hotelState: wm.HotelState, loadAgain: wm.loadAgain),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;
  final UnionStateNotifier<Hotel> hotelState;
  final VoidCallback loadAgain;

  const _Body({
    required this.openNextScreen,
    required this.hotelState,
    required this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<Hotel>(
        unionStateListenable: hotelState,
        builder: (_, hotel) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _HotelWidget(hotel: hotel),
                const SizedBox(height: 8),
                _DetailInformationAboutHotelWidget(description: hotel.description, peculiarities: hotel.peculiarities),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: AppButtonWidget(
                      title: 'К выбору номера',
                      onPressed: openNextScreen,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        loadingBuilder: (_, hotel) => const LoadingHotelWidget(),
        failureBuilder: (_, exception, hotel) => AppErrorWidget(onPressed: loadAgain),
    );
  }
}

class _DetailInformationAboutHotelWidget extends StatelessWidget {
  final String description;
  final List<String> peculiarities;
  List<String> aboutHotel = ['Удобства', 'Что включено', 'Что не включено'];
  List<String> aboutHotelIcons = [SvgIcons.iconFacilities, SvgIcons.iconHotelInclude, SvgIcons.iconHotelUninclude];

  _DetailInformationAboutHotelWidget({required this.description, required this.peculiarities});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 21),
              child: Text(
                'Об отеле',
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Wrap(
                runSpacing: 8,
                children: [
                  ...peculiarities.map(
                        (e) =>
                        DecoratedBox(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                description,
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.black),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SvgPicture.asset(aboutHotelIcons[index]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(aboutHotel[index], style: AppTextStyle.medium16.value),
                                      const SizedBox(height: 2),
                                      Text('Самое необходимое', style: AppTextStyle.medium14.value.copyWith(color: AppColors.gray)),
                                    ],
                                  ),
                                  SvgPicture.asset(SvgIcons.iconArrow),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (index != 2) Container(height: 1, color: AppColors.gray.withOpacity(.15)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _HotelWidget extends StatelessWidget {
  final Hotel hotel;

  _HotelWidget({required this.hotel});

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppGalleryWidget(imageUrls: hotel.imageUrls,),
            ),
            AppRatingWidget(rating: hotel.rating, ratingName: hotel.ratingName),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                hotel.name,
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                hotel.adress,
                style: AppTextStyle.medium14.value.copyWith(color: AppColors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('от ${hotel.minimalPrice.toString().spaceSeparateNumbers()} ₽', style: AppTextStyle.semiBold30.value.copyWith(color: AppColors.black)),
                  const SizedBox(width: 8),
                  Text(hotel.priceForIt, style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

