import 'package:flutter_template/api/service/hotel_api.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/hotel_mapper.dart';
import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';

class HotelRepository {
  late final HotelApi _apiClient;

  HotelRepository(this._apiClient);

  Future<Hotel?> getHotel() async {
    final some = await _apiClient.getHotel();
    return mapResponseToHotel(some);
  }
}
