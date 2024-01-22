import 'package:flutter/foundation.dart';
import 'package:flutter_template/api/data/rooms_response.dart';
import 'package:flutter_template/features/common/domain/data/rooms/room_data.dart';
import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';

/// Map [RoomsResponse] to [Rooms]
Rooms? mapResponseToRooms(RoomsResponse response) {
  try {
    return Rooms(
      rooms: response.rooms
              ?.map(
                (e) => Room(
                  name: e.name ?? '',
                  price: e.price ?? 0,
                  pricePer: e.pricePer ?? '',
                  peculiarities: e.peculiarities ?? [],
                  imageUrls: e.imageUrls ?? [],
                ),
              )
              .toList() ??
          [],
    );
  } on Exception catch (_, e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
