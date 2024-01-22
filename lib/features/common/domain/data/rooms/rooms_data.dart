import 'package:flutter_template/features/common/domain/data/rooms/room_data.dart';

class Rooms {
  final List<Room> rooms;

  ///
  Rooms({
    required this.rooms,
  });

  Rooms copyWith({
    final List<Room>? rooms,
  }) {
    return Rooms(
      rooms: rooms ?? this.rooms,
    );
  }

  static Rooms init() => Rooms(
    rooms: [],
  );
}
