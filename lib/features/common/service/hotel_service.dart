import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';
import 'package:flutter_template/features/common/domain/repository/hotel_repository.dart';

class HotelService {
  final HotelRepository _hotelRepository;

  HotelService(this._hotelRepository);

  Future<Hotel?> getHotel() async {
    return _hotelRepository.getHotel();
  }
}
