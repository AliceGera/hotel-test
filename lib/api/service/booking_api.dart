import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/booking_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'booking_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class BookingApi {
  ///
  factory BookingApi(Dio dio) = _BookingApi;

  ///
  @GET(ApiStrings.bookingPath)
  Future<BookingResponse> getBooking();
}
