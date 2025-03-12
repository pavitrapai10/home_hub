class ServicesDetails{
  final String serviceName;   
  final String imagePath;
  final String providerName;
  final String rating;
  final String charge;


 ServicesDetails({required this.serviceName,
  required this.imagePath, 
  required this.providerName, 
  required this.rating, 
  required this.charge});

  factory ServicesDetails.fromJson(Map<String, dynamic> json) {
    return ServicesDetails(
      serviceName: json['serviceName'],
      imagePath: json['imagePath'],
      providerName: json['providerName'],
      rating: json['rating'],
      charge: json['charge']
    );
  } 
}
