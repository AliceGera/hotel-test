import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/hotel_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'hotel_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class HotelApi {
  ///
  factory HotelApi(Dio dio) = _HotelApi;

  ///
  @GET(ApiStrings.basePath)
  Future<HotelResponse> getHotel();
}
