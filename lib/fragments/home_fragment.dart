import 'package:flutter/material.dart';
import '../models/customer_review_model.dart';
import '../components/customer_review_component.dart';

class HomeFragment extends StatelessWidget {
  final PageController reviewPagesController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Te Resuelvo", textAlign: TextAlign.center),
        leading: Row(
          children: [
            SizedBox(width: 10),
            Image.asset('assets/images/TeResuelvoLogo.png', height: 30),
          ],
        ),
        actions: [
          DropdownButton<String>(
            value: 'Option 1',
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            onChanged: (String? newValue) {},
            items: ['Option 1', 'Option 2', 'Option 3']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for services",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: PageView(
                children: [
                  Image.asset('assets/images/banner.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/banner1.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            categorySection("Home Services", ['Plumber', 'Electrician', 'Painting', 'Carpenter', 'Cleaning']),
            categorySection("Home Construction", ['Construction', 'Architects', 'Interior Design', 'Furniture']),
            categorySection("Popular Services", ['Service 1', 'Service 2', 'Service 3', 'Service 4']),
            buildCustomerReviewsSection(), // Added Customer Reviews Section
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget categorySection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("View All", style: TextStyle(color: Colors.orange)),
            ],
          ),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items
                  .map((item) => Container(
                        width: 80,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(item)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Customer Reviews Section
  Widget buildCustomerReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("What our customers say", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 117,
          child: PageView.builder(
            itemCount: customerReviews.length,
            controller: reviewPagesController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomerReviewComponent(customerReviewModel: customerReviews[index]);
            },
          ),
        ),
      ],
    );
  }
}
