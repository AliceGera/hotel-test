import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_widget_model.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/extension/string_extension.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_raiting_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:union_state/union_state.dart';

/// Initialization screens (this can be a HomeScreen or SplashScreen for example).
@RoutePage(
  name: AppRouteNames.bookingScreen,
)
class BookingScreen extends ElementaryWidget<BookingScreenWidgetModel> {
  /// Create an instance [BookingScreen].

  const BookingScreen({
    Key? key,
    WidgetModelFactory wmFactory = bookingScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(BookingScreenWidgetModel wm) {
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
            Text('Бронирование', style: AppTextStyle.medium18.value.copyWith(color: AppColors.black)),
            const Spacer(),
          ],
        ),
      ),
      body: _Body(openNextScreen: wm.openNextScreen, bookingState: wm.BookingState),
    );
  }
}

class _Body extends StatelessWidget {
  final VoidCallback openNextScreen;
  final UnionStateNotifier<Booking> bookingState;

  const _Body({
    required this.openNextScreen,
    required this.bookingState,
  });

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<Booking>(
        unionStateListenable: bookingState,
        builder: (_, booking) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _HotelWidget(booking: booking),
                const SizedBox(height: 8),
                _BookingInformationWidget(booking: booking),
                const SizedBox(height: 8),
                _BuyerInformationWidget(),
                const SizedBox(height: 8),
                _AddTourist(),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Text(
                          'Добавить туриста',
                          style: AppTextStyle.medium22.value,
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SvgPicture.asset(SvgIcons.iconAddTourist),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _FinalPayment(booking: booking),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: AppButtonWidget(
                      title: 'Оплатить ${(booking.tourPrice + booking.fuelCharge + booking.serviceCharge).toString().spaceSeparateNumbers()}  ₽',
                      onPressed: openNextScreen,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loadingBuilder: (_, booking) => SizedBox(),
        failureBuilder: (_, booking, rooms) => SizedBox());
  }
}

class _BookingInformationWidget extends StatelessWidget {
  final Booking booking;

  const _BookingInformationWidget({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InformationWidget(firstText: 'Вылет из', secondText: booking.departure),
            _InformationWidget(firstText: 'Страна, город', secondText: booking.arrivalCountry),
            _InformationWidget(firstText: 'Даты', secondText: '${booking.tourDateStart} - ${booking.tourDateStop}'),
            _InformationWidget(firstText: 'Кол-во ночей', secondText: booking.numberNights.toString()),
            _InformationWidget(firstText: 'Отель', secondText: booking.hotelName),
            _InformationWidget(firstText: 'Номер', secondText: booking.room),
            _InformationWidget(firstText: 'Питание', secondText: booking.nutrition),
          ],
        ),
      ),
    );
  }
}

class _HotelWidget extends StatelessWidget {
  final Booking booking;

  _HotelWidget({
    required this.booking,
  });

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRatingWidget(rating: booking.horating, ratingName: booking.ratingName),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                booking.hotelName,
                style: AppTextStyle.medium22.value.copyWith(color: AppColors.black),
              ),
            ),
            Text(
              booking.hotelAdress,
              style: AppTextStyle.medium14.value.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({required this.firstText, required this.secondText});

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstText,
                  style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(secondText, style: AppTextStyle.regular16.value),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BuyerInformationWidget extends StatelessWidget {
  final mask = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Информация о покупателе',
                  style: AppTextStyle.medium22.value,
                ),
              ),
              _TextFieldWidget(text: '+7 (***) ***-**-**', input: [mask]),
              const SizedBox(height: 8),
              const _TextFieldWidget(text: 'examplemail.000@mail.ru'),
              const SizedBox(height: 8),
              Text(
                'Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
                style: AppTextStyle.medium14.value.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget({
    required this.text,
    this.input = const <TextInputFormatter>[],
  });

  final String text;
  final List<TextInputFormatter> input;

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: textFieldKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          inputFormatters: input,
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: AppColors.red),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: AppColors.red, width: 0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(width: 0, color: AppColors.gray),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(width: 0, color: AppColors.gray),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: AppColors.backgroundColor,
            filled: true,
            labelText: text,
            labelStyle: const TextStyle(color: AppColors.gray),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }
}

class _FinalPayment extends StatelessWidget {
  List<String> bookingInformationList = [
    'Тур',
    'Топливный сбор',
    'Сервисный сбор',
    'К оплате',
  ];
  final Booking booking;

  _FinalPayment({
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PriceWidget(text: 'Тур', textPrice: '${booking.tourPrice} ₽'),
            _PriceWidget(text: 'Топливный сбор', textPrice: '${booking.fuelCharge} ₽'),
            _PriceWidget(text: 'Сервисный сбор', textPrice: '${booking.serviceCharge} ₽'),
            _PriceWidget(text: 'К оплате', textPrice: '${booking.tourPrice + booking.fuelCharge + booking.serviceCharge} ₽', color: AppColors.blue),
          ],
        ),
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget({required this.text, required this.textPrice, this.color});

  final String text;
  final String textPrice;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppTextStyle.regular16.value.copyWith(color: AppColors.gray)),
          Text(textPrice.spaceSeparateNumbers(), style: AppTextStyle.regular16.value),
        ],
      ),
    );
  }
}

class _AddTourist extends StatelessWidget {
  _AddTourist();

  bool isOpenCustomArrow = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExpansionTile(
            trailing: (isOpenCustomArrow ? SvgPicture.asset(SvgIcons.iconOpenTourist) : SvgPicture.asset(SvgIcons.iconCloseTourist)),
            collapsedTextColor: AppColors.black,
            backgroundColor: AppColors.white,
            textColor: AppColors.black,
            title: Text('Первый турист', style: AppTextStyle.medium22.value),
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Имя'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Фамилия'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Дата рождения'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Гражданство'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Номер загранпаспорта'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _TextFieldWidget(text: 'Срок действия загранпаспорта'),
              ),
              SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
