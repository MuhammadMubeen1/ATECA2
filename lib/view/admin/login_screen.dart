

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employe_portal/view/admin/signupscreen.dart';
import 'package:employe_portal/view/admin/users_screen.dart';
import 'package:employe_portal/view/admin/web.dart';
import 'package:employe_portal/view/user/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:employe_portal/widgetss/custom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:employe_portal/view/user/user_inof.dart';



class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> authenticateUser(String email, String password) async {
  try {
    // Try to sign in with Firebase Authentication
    try {
     

      // User found in Firebase Authentication, now check if they are an admin
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Admin user found
        await setLoggedIn(isAdmin: true, email: email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => aUsers(), // Replace with your admin screen
          ),
        );
        Fluttertoast.showToast(
          msg: "Successful Login as Admin",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor:const  Color(0xff2476BD),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Regular user found
        await setLoggedIn(isAdmin: false, email: email);
         UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => User_Info(currentEmail: email), // Replace with your user screen
          ),
        );
        Fluttertoast.showToast(
          msg: "Successful Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff2476BD),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // User not found in Firebase Authentication, check in Firestore
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('AllEmployees')
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          // User found in Firestore
          await setLoggedIn(isAdmin: false, email: email);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => User_Info(currentEmail: email), // Replace with your user screen
            ),
          );
          Fluttertoast.showToast(
            msg: "Successful Login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff2476BD),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          // No user found
          Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff2476BD),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        // Handle other FirebaseAuth exceptions
        Fluttertoast.showToast(
          msg: "Authentication error: ${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff2476BD),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred')),
    );
  }
}


  Future<void> setLoggedIn({required bool isAdmin, required String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('isAdmin', isAdmin);
    await prefs.setString('email', email); // Save email in SharedPreferences
  }

  Future<void> showForgotPasswordDialog() async {
    TextEditingController emailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
          title: const Text('Forgot Password', style: TextStyle(color: Color(0xff2476BD)),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                prefixIcon:const  Icon(Icons.email_outlined, color: Colors.grey),
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                      .collection('AllEmployees')
                      .where('email', isEqualTo: email)
                      .get();

                  if (userSnapshot.docs.isNotEmpty) {
                    Navigator.pop(context);
                    showUpdatePasswordDialog(email);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Email not found",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xff2476BD),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }
              },
              child:const  Text('Verify Email', style: TextStyle(color: Color(0xff2476BD)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Color(0xff2476BD)),),
            ),
          ],
        );
      },
    );
  }

  Future<void> showUpdatePasswordDialog(String email) async {
    TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Update Password', style: TextStyle(color: Color(0xff2476BD),),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                hintText: 'New Password',
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String newPassword = passwordController.text.trim();
                if (newPassword.isNotEmpty) {
                  // Update password in Firestore
                  QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                      .collection('admin')
                      .where('email', isEqualTo: email)
                      .get();

                  if (userSnapshot.docs.isNotEmpty) {
                    DocumentReference userDoc = userSnapshot.docs.first.reference;
                    await userDoc.update({'password': newPassword});
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Password updated successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color(0xff2476BD),
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  }
                }
              },
              child: const Text('Update Password', style: TextStyle(color: Color(0xff2476BD)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Color(0xff2476BD)),),
            ),
          ],
        );
      },
    );
  }
  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 84),
                child: Center(
                  child: Image.asset(
                    "assets/images/atecalogo.png",
                    height: 82,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 178),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color(0xff2476BD),
                          fontWeight: FontWeight.w600,
                          fontSize: 25),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xff2476BD)
                ),
                hintText: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Should not be empty';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(
                height: 20,
              ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 30),
               child: TextFormField(
                 
                   textCapitalization: TextCapitalization.none,
                   controller: _passwordController,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0), 
                    fillColor: Colors.white,
                    filled: true,
                     hintText: "Password",
                     hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                     suffixIcon: IconButton(
                       icon: Icon(
                         _passwordVisible ? Icons.visibility : Icons.visibility_off,
                         color: Color(0xff2476BD),
                      
                       ),
                       onPressed: () {
                         setState(() {
                           _passwordVisible = !_passwordVisible;
                         });
                       },
                     ),
                     prefixIcon: const Icon(
                       Icons.password_outlined,
                        color: Color(0xff2476BD),
                     ),
                     border: OutlineInputBorder(
                       
                       borderRadius: BorderRadius.circular(18,),
                        // Adjust the radius as needed
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
                       borderSide:  BorderSide(
                          color:  Colors.grey.shade300
                    // Adjust the border color as needed
                       ),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
                       borderSide:  BorderSide(
                         color:  Colors.grey.shade300
                        // Adjust the border color as needed
                       ),
                     ),
                   ),
                   obscureText: !_passwordVisible,
                   validator: (v) {
                     if (v == null || v.isEmpty) {
                       return "Password should not be empty";
                     } else {
                       return null;
                     }
                   },
                 ),
             ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:  const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                    onTap: (){
 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>ForgotPassword(),
                                    ),
                                  );
                    },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color(0xff2476BD),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2476BD),
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size.fromHeight(55),
                    ),
                    onPressed: _isLoading
                        ? null // Disable button if loading
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading =
                                    true; // Set isLoading to true immediately
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xff2476BD),
                                  content: Text(
                                    'Please wait...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                              await authenticateUser(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              setState(() {
                                _isLoading =
                                    false; // Set isLoading to false after completion
                              });
                            }
                          },
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xff2476BD),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Text(
                                "Please Wait...",
                                style: TextStyle(
                                  color: Color(0xff2476BD),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),

const SizedBox(height: 6,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const  Text(
                      "Create a new account",
                     style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const  SizedBox(width: 4),
                     Center(
                        child: GestureDetector(
                          onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>Signup (email: '',),
                                    ),
                                  );
                                },
                          child: const  Text(
                           "Sign Up",
                           style: TextStyle( color: Color(0xff2476BD), fontWeight: FontWeight.bold ),
                           
                          ),
                        ),
                                           ),
          
                  ],
                ),
              const SizedBox(height: 8),


               Container(
 
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,

    children: [
      Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewScreen(
                                        
                                        url: 'https://atecaconsulting.com/privacy-policy.html',
                                        title: 'Terms of Use (EULA)',
                                        
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Terms of Use (EULA)",
                                  style: TextStyle(
                                    color: Color(0xff2476BD),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                     // Set text color to blue
                                  ),
                                ),
                              ),
                              const Text(" and "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewScreen(

                                        url: 'https://atecaconsulting.com/privacy-policy.html',
                                        title: 'Privacy Policy',
                                        
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 12,
                                        color: Color(0xff2476BD),
                                    fontWeight: FontWeight.bold,
                                    // Set text color to blue
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

           
            ],
          ),
        ),
      ),
    );
  }
}