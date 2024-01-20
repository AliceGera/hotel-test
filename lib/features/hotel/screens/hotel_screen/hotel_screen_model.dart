import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/hotel/screens/hotel_screen/hotel_screen.dart';

/// Model for [HotelScreen].
class HotelScreenModel extends ElementaryModel implements IHotelScreenModel {
  /// Create an instance [HotelScreenModel].
  HotelScreenModel();
}

/// Interface of [HotelScreenModel].
abstract class IHotelScreenModel extends ElementaryModel {}
