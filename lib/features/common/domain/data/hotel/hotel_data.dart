class Hotel {
  final String name;
  final String adress;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final String description;
  final List<String> peculiarities;
  final List<String> imageUrls;

  ///
  Hotel({
    required this.name,
    required this.adress,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.description,
    required this.peculiarities,
    required this.imageUrls,
  });

  Hotel copyWith({
    final String? name,
    final String? adress,
    final int? minimalPrice,
    final String? priceForIt,
    final int? rating,
    final String? ratingName,
    final String? description,
    final List<String>? peculiarities,
    final List<String>? imageUrls,
  }) {
    return Hotel(
      name: name ?? this.name,
      adress: adress ?? this.adress,
      minimalPrice: minimalPrice ?? this.minimalPrice,
      priceForIt: priceForIt ?? this.priceForIt,
      rating: rating ?? this.rating,
      ratingName: ratingName ?? this.ratingName,
      description: description ?? this.description,
      peculiarities: peculiarities ?? this.peculiarities,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  static Hotel init() => Hotel(
        name: '',
        adress: '',
        minimalPrice: 0,
        priceForIt: '',
        rating: 0,
        ratingName: '',
        description: '',
        peculiarities: [],
      imageUrls:[],
      );
}
