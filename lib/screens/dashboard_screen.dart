import 'package:flutter/material.dart';
import '../store/home_store.dart';
import '../fragments/search_fragment.dart';
import '../models/common_model.dart';
import '../models/services_model.dart';
import '../utils/images.dart';
import 'notification_screen.dart';
import 'services_screen.dart';
import '../fragments/account_fragment.dart';
import '../models/home_construction_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeStore homeStore = HomeStore();

  int _selectedIndex = 0;
  int? selectedServiceIndex;
  int? selectedConstructionIndex;

  final List<Widget> _screens = [
    Placeholder(), // Replace with actual Home Screen Widget
    Placeholder(), // Bookings Placeholder
    Placeholder(), // Chats Placeholder
    AccountFragment(), // Profile Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("Menu Clicked");
              },
              child: Image.asset(
                new_splash_logo,
                height: 40,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'TeResuelvo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: _selectedIndex == 0
          ? SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ Search & Dropdown Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: SearchFragment()),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          value: homeStore.selectedCategory.isNotEmpty
                              ? homeStore.selectedCategory
                              : 'Choose Category',
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
                  ),

                  /// ✅ Banner Section
                  SizedBox(
                    height: 150,
                    child: PageView(
                      children: homeStore.banners.map((banner) {
                        return Image.asset(banner, fit: BoxFit.cover, width: double.infinity);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// ✅ Home Services Section (Circular Icons)
                  _buildIconList("Home Services", serviceProviders.sublist(0, 5)),

                  /// ✅ Home Construction Section (Circular Icons)
                  _buildHomeConstructionSection(),

                  /// ✅ Popular Services Section (Images)
                  _buildImageList("Popular Services"),

                  SizedBox(height: 20),
                ],
              ),
            )
          : _selectedIndex == 3
              ? AccountFragment() // ✅ Show Profile Screen
              : Center(child: Text("Coming Soon")), // ✅ Placeholder for Bookings/Chats

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  /// ✅ Home Services Section (Circular Icons)
  Widget _buildIconList(String title, List<ServicesModel> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                child: Text("View All", style: TextStyle(fontSize: 14, color: Colors.blue)),
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
                  setState(() {
                    selectedServiceIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedServiceIndex == index ? Colors.black : Colors.grey[200],
                      ),
                      child: Icon(item.serviceIcon, color: selectedServiceIndex == index ? Colors.white : Colors.black, size: 30),
                    ),
                    SizedBox(height: 5),
                    Text(item.serviceName, style: TextStyle(fontSize: 14)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// ✅ Home Construction Section (Circular Icons)
  Widget _buildHomeConstructionSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Home Construction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceScreen()),
                );
              },
              child: Text("View All", style: TextStyle(fontSize: 14, color: Colors.blue)),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeConstruction.length,
          itemBuilder: (context, index) {
            var item = homeConstruction[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedConstructionIndex = index;
                });
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedConstructionIndex == index ? Colors.black : Colors.grey[200],
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                        color: selectedConstructionIndex == index ? Colors.white : Colors.black,
                      ),
                      child: item.iconPath!,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(item.title, style: TextStyle(fontSize: 14)),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}



  /// ✅ Popular Services Section (Images)
  Widget _buildImageList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                child: Text("View All", style: TextStyle(fontSize: 14, color: Colors.blue)),
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
              return Container(
                width: 130,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(item.serviceImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(item.serviceName, style: TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
