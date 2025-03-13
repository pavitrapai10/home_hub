import 'package:flutter/material.dart';
import 'package:home_services/utils/colors.dart';

InputDecoration commonInputDecoration({String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}




class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNav({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,   
      unselectedFontSize: 12, 
      type: BottomNavigationBarType.fixed, 
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

// Widget homeTitleWidget({
//   String? titleText,
//   String? viewAllText,
//   Function()? onAllTap,
// }) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(titleText!, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
//         TextButton(
//           child: Text(
//             viewAllText ?? "View All",
//             style: TextStyle(color: viewAllColor, fontSize: 16, fontWeight: FontWeight.normal),
//           ),
//           onPressed: onAllTap!,
//         ),
//       ],
//     ),
//   );
// }

// Widget drawerWidget({String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
//   return ListTile(
//     horizontalTitleGap: 0,
//     visualDensity: VisualDensity.compact,
//     leading: Icon(drawerIcon!, size: 20),
//     title: Text(drawerTitle!, style: TextStyle()),
//     onTap: drawerOnTap!,
//   );
// }

// Future<void> showAlertDialog(BuildContext context, {int? index}) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Are you sure to book that service again?'),
//         actions: [
//           TextButton(
//             child: Text('No'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             child: Text('Yes'),
//             onPressed: () {
//               againBooking(index!);
//               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashBoardScreen()), (route) => false);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
