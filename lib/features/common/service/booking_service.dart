import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/domain/repository/booking_repository.dart';

class BookingService {
  final BookingRepository _bookingRepository;

  BookingService(this._bookingRepository);

  Future<Booking?> getBooking() async {
    return _bookingRepository.getBooking();
  }
}
