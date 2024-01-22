class Room {
  final String name;
  final int price;
  final String pricePer;
  final List<String> peculiarities;
  final List<String> imageUrls;

  ///
  Room({
    required this.name,
    required this.price,
    required this.pricePer,
    required this.peculiarities,
    required this.imageUrls,
  });

  Room copyWith({
    final String? name,
    final int? price,
    final String? pricePer,
    final List<String>? peculiarities,
    final List<String>? imageUrls,
  }) {
    return Room(
      name: name ?? this.name,
      price: price ?? this.price,
      pricePer: pricePer ?? this.pricePer,
      peculiarities: peculiarities ?? this.peculiarities,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  static Room init() => Room(
        name: '',
        price: 0,
        pricePer: '',
        peculiarities: [],
        imageUrls: [],
      );
}
