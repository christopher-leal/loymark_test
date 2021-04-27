class Country {
  Country({
    this.id,
    this.name,
    this.alpha2,
    this.alpha3,
  });
  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'] as int,
        name: json['name'] as String,
        alpha2: json['alpha2'] as String,
        alpha3: json['alpha3'] as String,
      );
  final int id;
  final String name;
  final String alpha2;
  final String alpha3;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'alpha2': alpha2,
        'alpha3': alpha3,
      };
}
