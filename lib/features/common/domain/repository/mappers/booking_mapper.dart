import 'package:flutter/foundation.dart';
import 'package:flutter_template/api/data/booking_response.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';

/// Map [BookingResponse] to [Booking]
Booking? mapResponseToBooking(BookingResponse response) {
  try {
    return Booking(
      hotelName: response.hotelName ?? '',
      hotelAdress: response.hotelAdress ?? '',
      horating: response.horating ?? 0,
      ratingName: response.ratingName ?? '',
      departure: response.departure ?? '',
      arrivalCountry: response.arrivalCountry ?? '',
      tourDateStart: response.tourDateStart ?? '',
      tourDateStop: response.tourDateStop ?? '',
      numberNights: response.numberNights ?? 0,
      room: response.room ?? '',
      nutrition: response.nutrition ?? '',
      tourPrice: response.tourPrice ?? 0,
      fuelCharge: response.fuelCharge ?? 0,
      serviceCharge: response.serviceCharge ?? 0,
    );
  } on Exception catch (_, e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
