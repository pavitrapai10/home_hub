import 'package:flutter/material.dart';
import 'package:home_services/utils/images.dart';

/// ✅ Direct List of Service Models Without Any Clickable Action
List<ServicesModel> serviceProviders = getServices();

class ServicesModel {
  int id;
  String serviceName;
  String serviceImage;
  IconData serviceIcon;
  bool isSelected;

  ServicesModel(
      this.id, this.serviceName, this.serviceImage, this.serviceIcon,
      {this.isSelected = false});
}

/// ✅ Final List With Images For Popular Services
List<ServicesModel> getServices() {
  List<ServicesModel> list = List.empty(growable: true);

  // ✅ Home Services (With Circle + Icon)
  list.add(ServicesModel(1, "Plumbers", plumber, Icons.plumbing));
  list.add(ServicesModel(2, "Electricians", electrician, Icons.cable_outlined));
  list.add(ServicesModel(3, "Painters", painter, Icons.format_paint));
  list.add(ServicesModel(4, "Carpenters", carpenter, Icons.handyman));
  list.add(ServicesModel(5, "Home Cleaning", homeCleaner, Icons.cleaning_services));

  // ✅ Popular Services (With Images)
  list.add(ServicesModel(6, "Car Washers", painter1, Icons.car_repair_outlined));
  list.add(ServicesModel(7, "Car Repairing", cleaning, Icons.home_repair_service));

  return list;
}

/// ✅ Handle Circle Click And Selection Toggle
void toggleServiceSelection(int index) {
  for (int i = 0; i < serviceProviders.length; i++) {
    if (i == index) {
      serviceProviders[i].isSelected = !serviceProviders[i].isSelected;
    } else {
      serviceProviders[i].isSelected = false;
    }
  }
}
