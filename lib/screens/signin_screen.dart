import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:home_services/screens/dashboard_screen.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import '../utils/constant.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedCountryCode = "+91";
  String? phoneError;
  String? passwordError;
  bool isPhoneValid = false;
  bool isPasswordValid = false;

  
  void validatePhoneNumber(String value) {
    String regexPattern = r'^[6-9]\d{9}$';
    var regExp = RegExp(regexPattern);

    setState(() {
      if (value.isEmpty) {
        phoneError = "Phone number is required";
        isPhoneValid = false;
      } else if (!regExp.hasMatch(value)) {
        phoneError = "Enter valid 10-digit phone number";
        isPhoneValid = false;
      } else {
        phoneError = null;
        isPhoneValid = true;
      }
    });
  }

  
  void validatePassword(String value) {
    String regexPattern =
        r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])[A-Za-z\d!@#\$%\^&\*]{8,}$';
    var regExp = RegExp(regexPattern);

    setState(() {
      if (value.isEmpty) {
        passwordError = "Password is required";
        isPasswordValid = false;
      } else if (value.length < 8) {
        passwordError = "Password must be at least 8 characters";
        isPasswordValid = false;
      } else if (!regExp.hasMatch(value)) {
        passwordError = "Must contain 1 uppercase, 1 number, 1 special character";
        isPasswordValid = false;
      } else {
        passwordError = null;
        isPasswordValid = true;
      }
    });
  }

  
  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountryCode = "+${country.phoneCode}";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            
            SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: mainTitleTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please Login to your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: subTitle,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

      
            SizedBox(height: 16),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Image.asset(
                  new_splash_logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            
            SizedBox(height: 30),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) => validatePhoneNumber(value),
              decoration: InputDecoration(
                hintText: "Enter mobile number",
                errorText: phoneError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: isPhoneValid ? Colors.green : Colors.red,
                  ),
                ),
                prefixIcon: GestureDetector(
                  onTap: () => _showCountryPicker(),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      _selectedCountryCode,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              onChanged: (value) => validatePassword(value),
              decoration: InputDecoration(
                hintText: "Enter password",
                errorText: passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: isPasswordValid ? Colors.green : Colors.red,
                  ),
                ),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

          
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isPhoneValid && isPasswordValid
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPhoneValid && isPasswordValid
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.grey,
              ),
              child: Text("Log In", style: TextStyle(color: Colors.white)),
            ),

        
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 10, 95, 253), 
                    decoration: TextDecoration.underline,  
                  ),
                ),
              ),
            ),

            
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                
                print("Navigate to Sign Up");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 4),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
