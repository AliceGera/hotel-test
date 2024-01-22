import 'package:flutter/foundation.dart';
import 'package:flutter_template/api/data/hotel_response.dart';
import 'package:flutter_template/features/common/domain/data/hotel/hotel_data.dart';

/// Map [HotelResponse] to [Hotel]
Hotel? mapResponseToHotel(HotelResponse response) {
  try {
    return Hotel(
      name: response.name ?? '',
      adress: response.adress ?? '',
      minimalPrice: response.minimalPrice ?? 0,
      priceForIt: response.priceForIt ?? '',
      rating: response.rating ?? 0,
      ratingName: response.ratingName ?? '',
      description: response.aboutHotel?.description ?? '',
      peculiarities: response.aboutHotel?.peculiarities.map((e) => e ?? '').toList() ?? [],
        imageUrls:response.imageUrls ?? [],
    );
  } on Exception catch (_, e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
