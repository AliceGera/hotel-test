import 'package:json_annotation/json_annotation.dart';

part 'room_response.g.dart';

///
@JsonSerializable(explicitToJson: true)
class RoomResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'price_per')
  final String? pricePer;
  @JsonKey(name: 'peculiarities')
  final List<String>? peculiarities;
  @JsonKey(name: 'image_urls')
  final List<String>? imageUrls;

  ///
  const RoomResponse({
    required this.name,
    required this.price,
    required this.pricePer,
    required this.peculiarities,
    required this.imageUrls,
  });

  factory RoomResponse.fromJson(Map<String, dynamic> json) => _$RoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomResponseToJson(this);
}

///
