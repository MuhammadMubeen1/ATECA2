import 'package:employe_portal/view/admin/users_screen.dart';
import 'package:employe_portal/view/user/user_inof.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> authenticateUser(BuildContext context, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check admin users collection
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Admin user found
        await _setLoggedIn(isAdmin: true, email: email);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => aUsers(), // Replace with your admin screen
          ),
        );// Replace with your admin screen route
        _showToast("Successful Login");
      } else {
        // Check regular users collection
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('AllEmployees')
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          // Regular user found
          await _setLoggedIn(isAdmin: false, email: email);
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => User_Info(currentEmail: email,), // Replace with your user screen
            ),
          );
          _showToast("Successful Login");
        } else {
          // No user found
          _showToast("Invalid email or password");
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }

    _isLoading = false;
    notifyListeners();
  }




  Future<void> _setLoggedIn({required bool isAdmin, required String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('isAdmin', isAdmin);
    await prefs.setString('email', email);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff2476BD),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
// import 'package:employe_portal/controllor/login_controllor.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:employe_portal/view/user/user_inof.dart';

// import 'package:employe_portal/widget/custom_button.dart';
// import 'package:employe_portal/widget/custom_textformfield.dart';


// class Login_Screen extends StatefulWidget {
//   @override
//   State<Login_Screen> createState() => _Login_ScreenState();
// }

// class _Login_ScreenState extends State<Login_Screen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _passwordVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 84),
//                 child: Center(
//                   child: Image.asset(
//                     "assets/images/atecalogo.png",
//                     height: 82,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 178),
//                 child: Center(
//                   child: Text(
//                     "Sign In",
//                     style: GoogleFonts.montserrat(
//                       textStyle: const TextStyle(
//                           color: Color(0xff2476BD),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 25),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextFormField(
//                 prefixIcon: const Icon(
//                   Icons.email_outlined,
//                   color: Colors.grey,
//                 ),
//                 hintText: 'Email',
//                 controller: _emailController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'This field is required';
//                   }
//                   return null; // Return null if the input is valid
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 30),
//                child: TextFormField(
                 
//                    textCapitalization: TextCapitalization.none,
//                    controller: _passwordController,
//                    decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                      hintText: "Password",
//                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
//                      suffixIcon: IconButton(
//                        icon: Icon(
//                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                          color: Colors.grey,
                      
//                        ),
//                        onPressed: () {
//                          setState(() {
//                            _passwordVisible = !_passwordVisible;
//                          });
//                        },
//                      ),
//                      prefixIcon: const Icon(
//                        Icons.password_outlined,
//                         color: Colors.grey,
//                      ),
//                      border: OutlineInputBorder(
                       
//                        borderRadius: BorderRadius.circular(18,),
//                         // Adjust the radius as needed
//                      ),
//                      enabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
//                        borderSide:  BorderSide(
//                           color:  Colors.grey.shade300
//                     // Adjust the border color as needed
//                        ),
//                      ),
//                      focusedBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(18), // Adjust the radius as needed
//                        borderSide:  BorderSide(
//                          color:  Colors.grey.shade300
//                         // Adjust the border color as needed
//                        ),
//                      ),
//                    ),
//                    obscureText: !_passwordVisible,
//                    validator: (v) {
//                      if (v == null || v.isEmpty) {
//                        return "Password should not be empty";
//                      } else {
//                        return null;
//                      }
//                    },
//                  ),
//              ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 50),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // authProvider.showForgotPasswordDialog(context);
//                       },
//                       child: Text(
//                         "Forgot Password?",
//                         style: GoogleFonts.montserrat(
//                           textStyle: const TextStyle(
//                               color: Color(0xff2476BD),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Container(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff2476BD),
//                       textStyle: const TextStyle(fontSize: 18),
//                       minimumSize: const Size.fromHeight(55),
//                     ),
//                     onPressed: authProvider.isLoading
//                         ? null // Disable button if loading
//                         : () async {
//                             if (_formKey.currentState!.validate()) {
//                               authProvider.authenticateUser(
//                                 context,
//                                 _emailController.text.trim(),
//                                 _passwordController.text.trim(),
//                               );
//                             }
//                           },
//                     child: authProvider.isLoading
//                         ? const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircularProgressIndicator(
//                                 color: Color(0xff2476BD),
//                               ),
//                               SizedBox(
//                                 width: 24,
//                               ),
//                               Text(
//                                 "Please Wait...",
//                                 style: TextStyle(
//                                   color: Color(0xff2476BD),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : const Text(
//                             "Submit",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }