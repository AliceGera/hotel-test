import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';
import 'package:flutter_template/features/common/service/rooms_service.dart';
import 'package:flutter_template/features/room/screen/room_screen.dart';


/// Model fol [RoomScreen].
class RoomScreenModel extends ElementaryModel {

  /// Create an instance [RoomScreenModel].
  final RoomsService _roomsService;
  /// Create an instance [RoomScreenModel].
  RoomScreenModel(this._roomsService): super();
  Future<Rooms?> getRooms() async {
    try {
      final rooms = await _roomsService.getRooms();
      return rooms;
    } on Object {
      rethrow;
    }
  }
}
