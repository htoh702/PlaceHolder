class KopoModel {
  final String address;
  final String zonecode;

  KopoModel({
    required this.address,
    required this.zonecode,
  });

  factory KopoModel.fromJson(Map<String, dynamic> json) {
    return KopoModel(
      address: json['address'],
      zonecode: json['zonecode'],
    );
  }
}
