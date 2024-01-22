import 'package:flutter_template/api/service/booking_api.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/booking_mapper.dart';

class BookingRepository {
  late final BookingApi _apiClient;

  BookingRepository(this._apiClient);

  Future<Booking?> getBooking() async {
    final some = await _apiClient.getBooking();
    return mapResponseToBooking(some);
  }
}
