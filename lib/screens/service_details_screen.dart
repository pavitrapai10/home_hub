import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../models/services_details.dart';
import '../utils/widgets.dart'; // Custom bottom navigation bar
import '../fragments/account_fragment.dart';
import 'dashboard_screen.dart';
import '../models/services_list.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final Services service;


  ServiceDetailsScreen({required this.service});


  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}
class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  List<ServicesDetails> servicesDetails = [];
  List<ServicesDetails> filteredServices = [];
  int _selectedIndex = 1; // Default index for Services

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/serviceProviderDetails.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      servicesDetails = data.map((e) => ServicesDetails.fromJson(e)).toList();
      filteredServices = servicesDetails;
    });
  }

  void filterSearch(String query) {
    setState(() {
      filteredServices = servicesDetails
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
          // AppBar with search bar
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    "Service Providers",
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
                              (a, b) => a.providerName.compareTo(b.providerName));
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

          // Scrollable ListView
          Expanded(
            child: filteredServices.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left Side - Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    service.imagePath,
                                    width: 90,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),

                                // Right Side - Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        service.providerName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        service.serviceName,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey[700]),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 20),
                                          SizedBox(width: 4),
                                          Text(
                                            service.rating.toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Right Bottom Section
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      service.charge,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle booking action
                                      },
                                      child: Text(
                                        "Book",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
