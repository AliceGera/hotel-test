import 'package:json_annotation/json_annotation.dart';

part 'about_hotel_response.g.dart';
@JsonSerializable(explicitToJson: true)
class AboutHotelResponse {
  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'peculiarities')
  final List<String?> peculiarities;

  const AboutHotelResponse({
    required this.description,
    required this.peculiarities,
  });

  factory AboutHotelResponse.fromJson(Map<String, dynamic> json) => _$AboutHotelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AboutHotelResponseToJson(this);
}
