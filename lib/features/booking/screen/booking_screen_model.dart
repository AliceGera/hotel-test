import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/booking/screen/booking_screen.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/service/booking_service.dart';

/// Model for [BookingScreen].
class BookingScreenModel extends ElementaryModel {
  /// Create an instance [BookingScreenModel].
  final BookingService _bookingService;

  /// Create an instance [BookingScreenModel].
  BookingScreenModel(this._bookingService) : super();

  Future<Booking?> getBooking() async {
    try {
      final booking = await _bookingService.getBooking();
      return booking;
    } on Object {
      rethrow;
    }
  }
}
