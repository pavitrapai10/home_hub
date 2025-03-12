class Services{
  final  String serviceName;   
  final String imagePath;

 Services({required this.serviceName, required this.imagePath});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      serviceName: json['serviceName'],
      imagePath: json['imagePath'],
    );
  } 
}
