import 'package:flutter_template/api/service/rooms_api.dart';
import 'package:flutter_template/features/common/domain/data/rooms/rooms_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/rooms_mapper.dart';

class RoomsRepository {
  late final RoomsApi _apiClient;

  RoomsRepository(this._apiClient);

  Future<Rooms?> getRooms() async {
    final some = await _apiClient.getRooms();
    return mapResponseToRooms(some);
  }
}
