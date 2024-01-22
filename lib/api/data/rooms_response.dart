import 'package:flutter_template/api/data/room_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rooms_response.g.dart';

///
@JsonSerializable(explicitToJson: true)
class RoomsResponse {
  @JsonKey(name: 'rooms')
  final List<RoomResponse>? rooms;


  ///
  const RoomsResponse({
    required this.rooms,
  });

  factory RoomsResponse.fromJson(Map<String, dynamic> json) => _$RoomsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomsResponseToJson(this);
}
