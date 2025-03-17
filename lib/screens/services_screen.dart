import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../models/services_list.dart';
import 'service_details_screen.dart';
import '../utils/widgets.dart';
import '../fragments/account_fragment.dart';
import 'dashboard_screen.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<Services> services = [];
  List<Services> filteredServices = [];
  int _selectedIndex = 1; // Default index for Services

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/services_list.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      services = data.map((e) => Services.fromJson(e)).toList();
      filteredServices = services;
    });
  }

  void filterSearch(String query) {
    setState(() {
      filteredServices = services
          .where((service) =>
              service.serviceName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0: // Home → Redirect to Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
      case 1: // Bookings → Show Alert
      case 2: // Chats → Show Alert
        _showComingSoonDialog();
        break;
      case 3: // Profile → Open Account Fragment
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountFragment()),
        );
        break;
    }
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Coming Soon"),
        content: Text("This feature will be available in future updates."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar with Search Bar
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    "Services",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                   actions: [
                    IconButton(
                      icon: Icon(Icons.sort_by_alpha),
                      onPressed: () {
                        setState(() {
                          filteredServices.sort(
                              (a, b) => a.serviceName.compareTo(b.serviceName));
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    onChanged: filterSearch,
                    decoration: InputDecoration(
                      hintText: "Search Services...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable ListView (Services List)
          Expanded(
            child: filteredServices.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return GestureDetector(
                        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ServiceDetailsScreen(service: service),
    ),
  );
},

                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Left Side - Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      service.imagePath,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16), // Space between image and text

                                  // Right Side - Text Details
                                  Expanded(
                                    child: Text(
                                      service.serviceName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
