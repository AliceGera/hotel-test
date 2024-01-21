import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/booking/screen/booking_screen.dart';

/// Model for [BookingScreen].
class BookingScreenModel extends ElementaryModel implements IBookingScreenModel {
  /// Create an instance [BookingScreenModel].
  BookingScreenModel();
}

/// Interface of [BookingScreenModel].
abstract class IBookingScreenModel extends ElementaryModel {}
