import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';
import 'package:flutter_template/features/common/service/hotel_service.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';

/// Model for [HotelScreen].
class HotelScreenModel extends ElementaryModel  {
  /// Create an instance [HotelScreenModel].
  final HotelService _hotelService;
  /// Create an instance [HotelScreenModel].
  HotelScreenModel(this._hotelService): super();
  Future<Hotel?> getHotel() async {
    try {
      final hotel = await _hotelService.getHotel();
      return hotel;
    } on Object {
      rethrow;
    }
  }
}
