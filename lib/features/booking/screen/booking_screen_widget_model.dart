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
BookingScreenWidgetModel bookingScreenWidgetModelFactory(BuildContext context,) {
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
  BookingScreenWidgetModel(super._model,
      this._appRouter,);

  final _bookingState = UnionStateNotifier<Booking>(Booking.init());
  final _touristsState = ValueNotifier<List<Tourist>>([]);
   late final Booking booking;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<List<TextEditingController>> _controllersList = [];

  @override
  void initWidgetModel() {
    _getBooking();
    addTourist(0);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _controllersList.map((e) => e.map((e) => e.dispose()));
    super.dispose();
  }

  @override
  void openNextScreen() {
    _appRouter.push(PaidRouter());
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

  void addTourist(int indexOfTourist) {
    model.addTourist();
    _controllersList.add(
      [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ],
    );
    _getTourists();
    _controllersList[indexOfTourist].asMap().forEach((indexOfValue, controller) {
      controller.addListener(() {
        model.setTouristData(
          indexOfTourist,
          indexOfValue,
          controller.text,
        );
      });
    });
  }

  void _getTourists() {
    final tourists = model.getTourists();
    _touristsState.value = tourists;
    _touristsState.notifyListeners();
  }

  @override
  void loadAgain() {
    _getBooking();
  }

  @override
  void changeTouristCard(int index) {
    final tourists = model.getTourists();
    tourists[index] = tourists[index].copyWith(isExpandTouristCard: !tourists[index].isExpandTouristCard);
    _touristsState.value = tourists;
    _touristsState.notifyListeners();
  }

  @override
  UnionStateNotifier<Booking> get bookingState => _bookingState;

  @override
  ValueNotifier<List<Tourist>> get touristsState => _touristsState;



  @override
  List<List<TextEditingController>> get controllersList => _controllersList;
}

/// Interface of [BookingScreenWidgetModel].
abstract class IBookingWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Navigate to room screen.
  void openNextScreen();

  /// Method to close the booking screens.
  void closeScreen() {}

  /// Method to load again booking screen.
  void loadAgain() {}

  UnionStateNotifier<Booking> get bookingState;

  ValueNotifier<List<Tourist>> get touristsState;

  void changeTouristCard(int index){}

  List<List<TextEditingController>> get controllersList;
}
