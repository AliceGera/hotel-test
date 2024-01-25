import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_model.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_widget_model.dart';
import 'package:flutter_template/features/booking/screen/widgets/booking_loading_widget.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/extension/string_extension.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/common/widgets/app_rating_widget.dart';
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
      body: _Body(bookingState: wm.bookingState, loadAgain: wm.loadAgain, wm: wm),
    );
  }
}

class _Body extends StatelessWidget {
  final UnionStateNotifier<Booking> bookingState;
  final VoidCallback loadAgain;
  final BookingScreenWidgetModel wm;

  const _Body({
    required this.bookingState,
    required this.loadAgain,
    required this.wm,
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
                _BuyerInformationWidget(wm: wm),
                const SizedBox(height: 8),
                _AddTourist(wm: wm),
                const SizedBox(height: 8),
                _FinalPayment(wm: wm),
              ],
            ),
          );
        },
        loadingBuilder: (_, booking) => const BookingLoadingWidget(),
        failureBuilder: (_, booking, rooms) => AppErrorWidget(onPressed: loadAgain));
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
  final BookingScreenWidgetModel wm;

  _BuyerInformationWidget({required this.wm});

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
              _TextFieldWidget(
                text: '+7 (***) ***-**-**',
                input: [mask],
                controller: wm.numberController,
                formKey: wm.formNumberKey,
                validatorText: wm.getNumberValidationTex,
              ),
              const SizedBox(height: 8),
              _TextFieldWidget(
                text: 'examplemail.000@mail.ru',
                controller: wm.emailController,
                formKey: wm.formEmailKey,
                validatorText: wm.getEmailValidationTex,
              ),
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

class _TextFieldWidget extends StatefulWidget {
  _TextFieldWidget({
    required this.text,
    required this.formKey,
    required this.controller,
    this.input = const <TextInputFormatter>[],
    this.validatorText,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String text;
  final List<TextInputFormatter> input;
  final String? Function()? validatorText;
  String? _currentValidationText;

  @override
  State<_TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<_TextFieldWidget> {
  _TextFieldWidgetState();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                setState(() {
                  widget._currentValidationText = widget.validatorText?.call();
                });
                return '';
              },
              inputFormatters: widget.input,
              controller: widget.controller,
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: AppColors.red),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.red.withOpacity(.15), width: 0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.gray),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: AppColors.gray),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.red.withOpacity(.15), width: 0),
                ),
                fillColor: widget._currentValidationText != null ? AppColors.red.withOpacity(0.15) : AppColors.backgroundColor,
                filled: true,
                labelText: widget.text,
                labelStyle: const TextStyle(color: AppColors.gray),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///function to convert index
String touristNumberFunction(String touristNumber) {
  switch (touristNumber) {
    case '0':
      touristNumber = 'Первый';
    case '1':
      touristNumber = 'Второй';
    case '2':
      touristNumber = 'Третий';
    case '3':
      touristNumber = 'Четвертый';
    case '4':
      touristNumber = 'Пятый';
    case '5':
      touristNumber = 'Шестой';
    case '6':
      touristNumber = 'Седьмой';
    case '7':
      touristNumber = 'Восьмой';
    case '8':
      touristNumber = 'Девятый';
    case '9':
      touristNumber = 'Десятый';
  }
  return touristNumber;
}

class _AddTourist extends StatelessWidget {
  final BookingScreenWidgetModel wm;

  _AddTourist({required this.wm});

  bool isOpenCustomArrow = false;
  String touristNumber = '';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Tourist>>(
      builder: (context, tourists, child) {
        return Column(
          children: [
            ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: tourists.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  touristNumber = touristNumberFunction(index.toString());
                  return ExpansionTile(
                    trailing: (tourists[index].isExpandTouristCard ? SvgPicture.asset(SvgIcons.iconCloseTourist) : SvgPicture.asset(SvgIcons.iconOpenTourist)),
                    onExpansionChanged: (expanded) {
                      wm.changeTouristCard(index);
                    },
                    maintainState: tourists[index].isExpandTouristCard,
                    backgroundColor: AppColors.white,
                    collapsedBackgroundColor: AppColors.white,
                    textColor: AppColors.black,
                    childrenPadding: EdgeInsets.zero,
                    collapsedShape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text('$touristNumber турист', style: AppTextStyle.medium22.value),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Имя',
                          formKey: wm.formComponents[index][0].formKey,
                          controller: wm.formComponents[index][0].controller,
                          validatorText: () => wm.validationTextForField(index, 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Фамилия',
                          formKey: wm.formComponents[index][1].formKey,
                          controller: wm.formComponents[index][1].controller,
                          validatorText: () => wm.validationTextForField(index, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Дата рождения',
                          formKey: wm.formComponents[index][2].formKey,
                          controller: wm.formComponents[index][2].controller,
                          validatorText: () => wm.validationTextForField(index, 2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Гражданство',
                          formKey: wm.formComponents[index][3].formKey,
                          controller: wm.formComponents[index][3].controller,
                          validatorText: () => wm.validationTextForField(index, 3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Номер загранпаспорта',
                          formKey: wm.formComponents[index][4].formKey,
                          controller: wm.formComponents[index][4].controller,
                          validatorText: () => wm.validationTextForField(index, 4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: _TextFieldWidget(
                          text: 'Срок действия загранпаспорта',
                          formKey: wm.formComponents[index][5].formKey,
                          controller: wm.formComponents[index][5].controller,
                          validatorText: () => wm.validationTextForField(index, 5),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 8,
                    //color: Styles.productRowDivider, // Custom style
                  );
                }),
            const SizedBox(height: 8),
            if (tourists.length < 10) ...[
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
                      onTap: () {
                        wm.addTourist(tourists.length);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(SvgIcons.iconAddTourist),
                      ),
                    )
                  ],
                ),
              ),
            ] else ...[
              Text('Можно добавить не больше 10-ти туристов', style: AppTextStyle.regular14.value),
            ],
          ],
        );
      },
      valueListenable: wm.touristsState,
    );
  }
}

class _FinalPayment extends StatelessWidget {
  final BookingScreenWidgetModel wm;

  const _FinalPayment({
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Tourist>>(
      builder: (context, tourists, child) {
        return Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PriceWidget(text: 'Тур', textPrice: '${wm.booking.tourPrice} * ${tourists.length} ₽'),
                    _PriceWidget(text: 'Топливный сбор', textPrice: '${wm.booking.fuelCharge} * ${tourists.length} ₽'),
                    _PriceWidget(text: 'Сервисный сбор', textPrice: '${wm.booking.serviceCharge} * ${tourists.length} ₽'),
                    _PriceWidget(
                        text: 'К оплате',
                        textPrice: '${(wm.booking.tourPrice + wm.booking.fuelCharge + wm.booking.serviceCharge) * tourists.length} ₽',
                        color: AppColors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: AppButtonWidget(
                  title:
                      'Оплатить ${((wm.booking.tourPrice + wm.booking.fuelCharge + wm.booking.serviceCharge) * tourists.length).toString().spaceSeparateNumbers()}  ₽',
                  onPressed: wm.onPressed,
                ),
              ),
            ),
          ],
        );
      },
      valueListenable: wm.touristsState,
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
