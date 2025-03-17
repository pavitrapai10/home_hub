import 'package:flutter/material.dart';
import '../store/home_store.dart';
import '../fragments/search_fragment.dart';
import '../utils/images.dart';
import 'notification_screen.dart';
import 'service_details_screen.dart';
import '../fragments/account_fragment.dart';
import '../models/home_construction_model.dart';
import '../utils/widgets.dart';
import '../models/services_list.dart';
import '../fragments/home_fragment.dart';
import 'services_screen.dart';
import '../models/common_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeStore homeStore = HomeStore();
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Placeholder(),
    Placeholder(),
    Placeholder(),
    AccountFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 final List<CommonModel> serviceProviders = [
  CommonModel.withImage("Plumbers", "assets/images/plumber.jpg"),
  CommonModel.withImage("Electricians", "assets/images/electrician.jpg"),
  CommonModel.withImage("Painters", "assets/images/painter.jpg"),
  CommonModel.withImage("Carpenters", "assets/images/carpenter.jpg"),
  CommonModel.withImage("Home Cleaning", "assets/images/home_cleaner.jpg"),
  CommonModel.withImage("Car Washers", "assets/images/painter1.jpg"),
  CommonModel.withImage("Car Repairing", "assets/images/electrician.jpg"),
];
final List<CommonModel> homeServices = [
  CommonModel.withoutImage("Plumbers", Icon(Icons.plumbing, size: 35)),
  CommonModel.withoutImage("Electricians", Icon(Icons.electrical_services, size: 35)),
  CommonModel.withoutImage("Painters", Icon(Icons.format_paint, size: 35)),
  CommonModel.withoutImage("Carpenters", Icon(Icons.chair, size: 35)),
  CommonModel.withoutImage("Home Cleaning", Icon(Icons.cleaning_services, size: 35)),
  CommonModel.withoutImage("Car Washers", Icon(Icons.local_car_wash, size: 35)),
  CommonModel.withoutImage("Car Repairing", Icon(Icons.car_repair, size: 35)),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildBanner(),
                  _buildIconList("Home Services", homeServices),
                  _buildHomeConstructionSection(),
                  _buildImageList("Popular Services"),
                  HomeFragment().buildCustomerReviewsSection(),
                  SizedBox(height: 20),
                ],
              ),
            )
          : _selectedIndex == 3
              ? AccountFragment()
              : Center(child: Text("Coming Soon")),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Menu Clicked");
            },
            child: Image.asset(new_splash_logo, height: 40),
          ),
          SizedBox(width: 8),
          Text(
            'Te Resuelvo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          Expanded(child: SearchFragment()),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: homeStore.selectedCategory.isNotEmpty ? homeStore.selectedCategory : 'Choose Category',
            onChanged: (newValue) {
              if (newValue != 'Choose Category') {
                homeStore.setSelectedCategory(newValue!);
              }
            },
            underline: SizedBox(),
            items: homeStore.categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 150,
      child: PageView(
        children: homeStore.banners.map((banner) {
          return Image.asset(banner, fit: BoxFit.cover, width: double.infinity);
        }).toList(),
      ),
    );
  }

  Widget _buildIconList(String title, List<CommonModel> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen()));
                },
                child: Text("View All", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              var item = services[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailsScreen(service: Services(serviceName: item.title, imagePath: "")),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      item.iconPath ?? Icon(Icons.home_repair_service, size: 40, color: Colors.grey),
                      SizedBox(height: 5),
                      Text(item.title, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

Widget _buildHomeConstructionSection() {
  return _buildIconList("Home Construction", homeConstruction); 
}




 Widget _buildImageList(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceScreen()),
                );
              },
              child: Text("View All", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue)),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: serviceProviders.length,
          itemBuilder: (context, index) {
            var item = serviceProviders[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsScreen(
                      service: Services(serviceName: item.title, imagePath: item.imagePath ?? ""),
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 120, // Fixed height for image
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: item.imagePath != null && item.imagePath!.isNotEmpty
                          ? DecorationImage(image: AssetImage(item.imagePath!), fit: BoxFit.cover)
                          : null, // No image if null
                      color: item.imagePath == null || item.imagePath!.isEmpty ? Colors.grey[300] : null,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(item.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
}