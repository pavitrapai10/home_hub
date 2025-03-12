import 'package:flutter/material.dart';
import '../utils/widgets.dart';

class SearchFragment extends StatelessWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200], 
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: TextField(
        decoration: commonInputDecoration(
          hintText: "Search for services",
          suffixIcon: Icon(Icons.search, size: 18, color: Colors.black), 
        ),
      ),
    );
  }
}
