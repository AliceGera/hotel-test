import 'package:dio/dio.dart';
import 'package:flutter_template/api/data/rooms_response.dart';
import 'package:flutter_template/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'rooms_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class RoomsApi {
  ///
  factory RoomsApi(Dio dio) = _RoomsApi;

  ///
  @GET(ApiStrings.roomsPath)
  Future<RoomsResponse> getRooms();
}
