import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/booking/screen/booking_screen.dart';
import 'package:flutter_template/features/booking/screen/booking_screen_model.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [BookingScreenWidgetModel].
BookingScreenWidgetModel bookingScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = BookingScreenModel(appScope.bookingService);
  return BookingScreenWidgetModel(
    model,
    appScope.router,
  );
}

/// Widget model for [BookingScreen].
class BookingScreenWidgetModel extends WidgetModel<BookingScreen, BookingScreenModel> with ThemeWMMixin implements IBookingWidgetModel {
  final AppRouter _appRouter;

  /// Create an instance [BookingScreenWidgetModel].
  BookingScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  final _bookingState = UnionStateNotifier<Booking>(Booking.init());
  final _touristsState = ValueNotifier<List<Tourist>>([]);
  late final Booking booking;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formNumberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formEmailKey = GlobalKey<FormState>();
  String? _numberValidationText;
  String? _emailValidationText;

  final List<List<FormComponents>> _formComponents = [];

  @override
  void initWidgetModel() {
    _numberController.addListener(
      () {
        if (_numberValidationText != null && _numberValidationText!.isNotEmpty) {
          _numberValidationText = null;
          _formNumberKey.currentState?.validate();
        }
        model.number = _numberController.text;
      },
    );
    _emailController.addListener(
      () {
        if (_emailValidationText != null && _emailValidationText!.isNotEmpty) {
          _emailValidationText = null;
          _formEmailKey.currentState?.validate();
        }
        model.email = _emailController.text;
      },
    );
    _getBooking();
    addTourist(0);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _emailController.dispose();
    _formComponents.map((e) => e.map((e) => e.controller.dispose()));
    super.dispose();
  }

  @override
  void closeScreen() {
    _appRouter.pop();
  }

  Future<void> _getBooking() async {
    _bookingState.loading();
    try {
      booking = (await model.getBooking())!;
      _bookingState.content(booking);
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (_) {
      _bookingState.failure();
    }
  }

  ///метод добавления туриста
  void addTourist(int indexOfTourist) {
    model.addTourist();
    _formComponents.add(
      List.generate(
        6,
        (index) => FormComponents.init(),
      ),
    );
    _getTourists();
    _formComponents[indexOfTourist].asMap().forEach((indexOfComponent, component) {
      component.controller.addListener(() {
        if (_formComponents[indexOfTourist][indexOfComponent].validatorText != null &&
            _formComponents[indexOfTourist][indexOfComponent].validatorText!.isNotEmpty) {
          _formComponents[indexOfTourist][indexOfComponent] = component.copyWith(validatorText: null);
          component.formKey.currentState?.validate();
        }
        model.setTouristData(
          indexOfTourist,
          indexOfComponent,
          component.controller.text,
        );
      });
    });
  }

  void _getTourists() {
    final tourists = model.getTourists();
    _touristsState
      ..value = tourists
      ..notifyListeners();
  }

  @override
  void loadAgain() {
    _getBooking();
  }

  @override
  void changeTouristCard(int index) {
    final tourists = model.getTourists();
    tourists[index] = tourists[index].copyWith(isExpandTouristCard: !tourists[index].isExpandTouristCard);
    _touristsState
      ..value = tourists
      ..notifyListeners();
  }

  @override
  String? validationTextForField(int indexOfTourist, int indexOfValue) {
    return _formComponents[indexOfTourist][indexOfValue].validatorText;
  }

  @override
  String? getNumberValidationTex() => _numberValidationText;

  @override
  String? getEmailValidationTex() => _emailValidationText;

  ///check for data
  static final RegExp dataRegex = RegExp(r'(([012][0-9])|(3[01]))\/([0]{0,1}[1-9]|1[012])\/\d{4} ([01][0-9]|[2][0-3]):([01345][0-9])');

  ///check for email
  static final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  void onPressed() {
    final tourists = model.getTourists();
    for (var touristIndex = 0; touristIndex < tourists.length; touristIndex++) {
      _formComponents[touristIndex].asMap().forEach((componentIndex, value) {
        if (componentIndex == 0 && tourists[touristIndex].name.isEmpty) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'заполните поле');
        }
        if (componentIndex == 1 && tourists[touristIndex].lastName.isEmpty) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'заполните поле');
        }
        if (componentIndex == 2 && dataRegex.hasMatch(tourists[touristIndex].birthday)) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'неверный формат');
        }
        if (componentIndex == 2 && tourists[touristIndex].birthday.isEmpty) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'заполните поле');
        }
        if (componentIndex == 3 && tourists[touristIndex].nationality.isEmpty) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'заполните поле');
        }
        if (componentIndex == 4 && tourists[touristIndex].passportNumber.length != 8) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'неверный формат');
        }
        if (componentIndex == 4 && tourists[touristIndex].passportNumber.isEmpty) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'заполните поле');
        }
        if (componentIndex == 5 && dataRegex.hasMatch(tourists[touristIndex].passportValidity)) {
          _formComponents[touristIndex][componentIndex] = _formComponents[touristIndex][componentIndex].copyWith(validatorText: 'неверный формат');
        }
        value.formKey.currentState?.validate();
      });
    }
    final isNumberCorrect = _numberController.text.isNotEmpty;
    if (!isNumberCorrect) {
      _numberValidationText = 'error';
      _formNumberKey.currentState?.validate();
    }
    final isEmailCorrect = _emailController.text.isNotEmpty;
    if (!isEmailCorrect) {
      _emailValidationText = 'error';
      _formEmailKey.currentState?.validate();
    }
    final isEmailCorrectWrite = emailRegex.hasMatch(_emailController.text);
    if (!isEmailCorrectWrite) {
      _emailValidationText = 'error';
      _formEmailKey.currentState?.validate();
    }

    final openNextScreen = _formComponents.every((element) => element.every((element) => element.validatorText == null)) && isNumberCorrect && isEmailCorrect &&
    isEmailCorrectWrite ;
    if (openNextScreen) {
      _appRouter.push(PaidRouter());
    }
  }

  @override
  UnionStateNotifier<Booking> get bookingState => _bookingState;

  @override
  ValueNotifier<List<Tourist>> get touristsState => _touristsState;

  @override
  List<List<FormComponents>> get formComponents => _formComponents;

  @override
  TextEditingController get numberController => _numberController;

  @override
  TextEditingController get emailController => _emailController;

  @override
  GlobalKey<FormState> get formNumberKey => _formNumberKey;

  @override
  GlobalKey<FormState> get formEmailKey => _formEmailKey;
}

/// Interface of [BookingScreenWidgetModel].
abstract class IBookingWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Method to close the booking screens.
  void closeScreen() {}

  /// Method to load again booking screen.
  void loadAgain() {}

  /// Method to load again booking screen.
  void onPressed() {}

  /// Method to get booking screen.
  UnionStateNotifier<Booking> get bookingState;

  /// Method to get tourists screen.
  ValueNotifier<List<Tourist>> get touristsState;

  /// Method to change tourist сard.
  void changeTouristCard(int index) {}

  /// Method give formComponents.
  List<List<FormComponents>> get formComponents;

  String? validationTextForField(int indexOfTourist, int indexOfValue);

  /// Method get number controller for number field
  TextEditingController get numberController;

  /// Method get email controller for email field
  TextEditingController get emailController;

  /// Method get formKey for number field
  GlobalKey<FormState> get formNumberKey;

  /// Method get formKey for email field
  GlobalKey<FormState> get formEmailKey;

  /// Method get validation text for number field
  String? getNumberValidationTex();

  /// Method get validation text for email field
  String? getEmailValidationTex();
}
