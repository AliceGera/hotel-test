import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/booking/screen/booking_screen.dart';
import 'package:flutter_template/features/common/domain/data/booking/booking_data.dart';
import 'package:flutter_template/features/common/service/booking_service.dart';

/// Model for [BookingScreen].
class BookingScreenModel extends ElementaryModel {
  /// Create an instance [BookingScreenModel].
  final BookingService _bookingService;
  final List<Tourist> _tourists = [];

  /// Create an instance [BookingScreenModel].
  BookingScreenModel(this._bookingService) : super();

  Future<Booking?> getBooking() async {
    try {
      final booking = await _bookingService.getBooking();
      return booking;
    } on Object {
      rethrow;
    }
  }

  List<Tourist> getTourists() {
    return _tourists;
  }

  void addTourist() {
    _tourists.add(Tourist.init());
  }

  void setTouristData(
    int indexOfTourist,
    int indexOfValue,
    String? value,
  ) {
    _tourists[indexOfTourist] = _tourists[indexOfTourist].copyWithIndex(
      indexOfValue: indexOfValue,
      value: value,
    );
  }
}

class Tourist {
  final String name;
  final String lastName;
  final String birthday;
  final String nationality;
  final String passportNumber;
  final String passportValidity;
  final bool isExpandTouristCard;

  Tourist({
    required this.name,
    required this.lastName,
    required this.birthday,
    required this.nationality,
    required this.passportNumber,
    required this.passportValidity,
    this.isExpandTouristCard = false,
  });

  Tourist copyWith({
    String? name,
    String? lastName,
    String? birthday,
    String? nationality,
    String? passportNumber,
    String? passportValidity,
    bool? isExpandTouristCard,
  }) {
    return Tourist(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      nationality: nationality ?? this.nationality,
      passportNumber: passportNumber ?? this.passportNumber,
      passportValidity: passportValidity ?? this.passportValidity,
      isExpandTouristCard: isExpandTouristCard ?? this.isExpandTouristCard,
    );
  }

  Tourist copyWithIndex({
    required int indexOfValue,
    String? value,
  }) {
    String? _name = name;
    String? _lastName = lastName;
    String? _birthday = birthday;
    String? _nationality = nationality;
    String? _passportNumber = passportNumber;
    String? _passportValidity = passportValidity;

    switch (indexOfValue) {
      case 0:
        _name = value;
      case 1:
        _lastName = value;
      case 2:
        _birthday = value;
      case 3:
        _nationality = value;
      case 4:
        _passportNumber = value;
      case 5:
        _passportValidity = value;
    }
    return Tourist(
      name: _name ?? '',
      lastName: _lastName ?? '',
      birthday: _birthday ?? '',
      nationality: _nationality ?? '',
      passportNumber: _passportNumber ?? '',
      passportValidity: _passportValidity ?? '',
    );
  }

  static Tourist init() => Tourist(
        name: '',
        lastName: '',
        birthday: '',
        nationality: '',
        passportNumber: '',
        passportValidity: '',
      );
}
