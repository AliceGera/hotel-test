class AboutHotel {
  final String description;
  final List<String> peculiarities;

  AboutHotel({
    required this.description,
    required this.peculiarities,
  });

  AboutHotel copyWith({
    String? description,
    List<String>? peculiarities,
  }) {
    return AboutHotel(
      description: description ?? this.description,
      peculiarities: peculiarities ?? this.peculiarities,
    );
  }

  static AboutHotel init() => AboutHotel(
        description: '',
        peculiarities: [],
      );
}
