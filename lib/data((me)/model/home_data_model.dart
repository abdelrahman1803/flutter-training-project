class HomeDataMModel {
  final int id;
  final String name;
  final String profilePath;

  HomeDataMModel({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory HomeDataMModel.fromJson(Map<String, dynamic> json) {
    return HomeDataMModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
    };
  }
}
