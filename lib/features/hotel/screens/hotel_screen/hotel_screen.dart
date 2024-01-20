import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

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
        backgroundColor: AppColors.white,
        title: Center(
          child: Text(
            'Отель',
            style: AppTextStyle.medium18.value.copyWith(color: AppColors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HotelWidget(),
            const SizedBox(height: 8),
            _DetailInformationAboutHotelWidget(),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: AppButtonWidget(
                  title: 'К выбору номера',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HotelWidget extends StatelessWidget {
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
              child: SizedBox(
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
            ),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          '5 Превосходно',
                          style: AppTextStyle.medium16.value.copyWith(color: AppColors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Steigenberger Makadi',
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Madinat Makadi, Safaga Road, Makadi Bay, Египет',
                style: AppTextStyle.medium14.value.copyWith(color: AppColors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'от 134 673 ₽',
                    style: AppTextStyle.semiBold30.value.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(width: 8),
                  Text('за тур с перелётом', style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailInformationAboutHotelWidget extends StatelessWidget {
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
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.black),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SvgPicture.asset(SvgIcons.iconFacilities),
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
                                      Text('Удобства', style: AppTextStyle.medium16.value),
                                      const SizedBox(height: 2),
                                      Text('Самое необходимое', style: AppTextStyle.medium14.value.copyWith(color: AppColors.gray)),
                                    ],
                                  ),
                                  SvgPicture.asset(SvgIcons.iconArrow),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(height: 1, color: AppColors.gray.withOpacity(.15)),
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
