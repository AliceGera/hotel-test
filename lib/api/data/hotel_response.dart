import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_template/api/data/about_hotel_response.dart';

part 'hotel_response.g.dart';

///
@JsonSerializable(explicitToJson: true)
class HotelResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'adress')
  final String? adress;
  @JsonKey(name: 'minimal_price')
  final int? minimalPrice;
  @JsonKey(name: 'price_for_it')
  final String? priceForIt;
  @JsonKey(name: 'rating')
  final int? rating;
  @JsonKey(name: 'rating_name')
  final String? ratingName;
  @JsonKey(name: 'about_the_hotel')
  final AboutHotelResponse? aboutHotel;
  @JsonKey(name: 'image_urls')
  final List<String>? imageUrls;


  ///
  const HotelResponse({
    required this.name,
    required this.adress,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.aboutHotel,
    required this.imageUrls,
  });

  factory HotelResponse.fromJson(Map<String, dynamic> json) => _$HotelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HotelResponseToJson(this);
}

///
