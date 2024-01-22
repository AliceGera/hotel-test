class Booking {
  final String hotelName;
  final String hotelAdress;
  final int horating;
  final String ratingName;
  final String departure;
  final String arrivalCountry;
  final String tourDateStart;
  final String tourDateStop;
  final int numberNights;
  final String room;
  final String nutrition;
  final int tourPrice;
  final int fuelCharge;
  final int serviceCharge;

  Booking({
    required this.hotelName,
    required this.hotelAdress,
    required this.horating,
    required this.ratingName,
    required this.departure,
    required this.arrivalCountry,
    required this.tourDateStart,
    required this.tourDateStop,
    required this.numberNights,
    required this.room,
    required this.nutrition,
    required this.tourPrice,
    required this.fuelCharge,
    required this.serviceCharge,
  });

  Booking copyWith({
    final String? hotelName,
    final String? hotelAdress,
    final int? horating,
    final String? ratingName,
    final String? departure,
    final String? arrivalCountry,
    final String? tourDateStart,
    final String? tourDateStop,
    final int? numberNights,
    final String? room,
    final String? nutrition,
    final int? tourPrice,
    final int? fuelCharge,
    final int? serviceCharge,
  }) {
    return Booking(
      hotelName: hotelName ?? this.hotelName,
      hotelAdress: hotelAdress ?? this.hotelAdress,
      horating: horating ?? this.horating,
      ratingName: ratingName ?? this.ratingName,
      departure: departure ?? this.departure,
      arrivalCountry: arrivalCountry ?? this.arrivalCountry,
      tourDateStart: tourDateStart ?? this.tourDateStart,
      tourDateStop: tourDateStop ?? this.tourDateStop,
      numberNights: numberNights ?? this.numberNights,
      room: room ?? this.room,
      nutrition: nutrition ?? this.nutrition,
      tourPrice: tourPrice ?? this.tourPrice,
      fuelCharge: fuelCharge ?? this.fuelCharge,
      serviceCharge: serviceCharge ?? this.serviceCharge,
    );
  }

  static Booking init() => Booking(
        hotelName: '',
        hotelAdress: '',
        horating: 0,
        ratingName: '',
        departure: '',
        arrivalCountry: '',
        tourDateStart: '',
        tourDateStop: '',
        numberNights: 0,
        room: '',
        nutrition: '',
        tourPrice: 0,
        fuelCharge: 0,
        serviceCharge: 0,
      );
}
