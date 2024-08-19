
import 'package:employe_portal/view/user/user_inof.dart';
import 'package:employe_portal/view/admin/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:employe_portal/view/admin/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
   
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkLoginStatus();
      }
    });
  }


Future<void> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isAdmin = prefs.getBool('isAdmin') ?? false;
  String currentEmail = prefs.getString('email') ?? ''; // Fetch current email from SharedPreferences

  if (isLoggedIn) {
    if (isAdmin) {
      // Navigate to admin screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => aUsers()), // Replace with your admin screen
      );
    } else {
      // Navigate to user info screen and pass current email
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => User_Info(currentEmail: currentEmail)),
      );
    }
  } else {
    // Navigate to login screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login_Screen()), // Replace with your login screen
    );
  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/atecalogo.png'), // Replace with your logo image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}