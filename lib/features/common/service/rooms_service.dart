import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';
import 'package:flutter_template/features/common/domain/repository/rooms_repository.dart';

class RoomsService {
  final RoomsRepository _roomsRepository;

  RoomsService(this._roomsRepository);

  Future<Rooms?> getRooms() async {
    return _roomsRepository.getRooms();
  }
}
