import 'package:flutter/material.dart';
import '../screens/signin_screen.dart';
import 'package:home_services/utils/colors.dart';
import 'package:home_services/utils/images.dart';
import '../custom_widget/space.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90, width: 90, child: CircleAvatar(backgroundImage: AssetImage(userImage))),
            Space(8),
            Text("User Name", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
            Space(4),
            Text("user@example.com", textAlign: TextAlign.start, style: TextStyle(color: secondaryColor, fontSize: 12)),
            Space(16),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.person, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("My Profile"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.favorite, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("My Favourites"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.notifications, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Notifications"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.mail, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Contact Us"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.question_mark, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Help Center"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.local_offer, size: 20),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Offers And Coupons"),
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: Icon(Icons.logout, size: 20, color: Colors.red),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: _logout,
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
