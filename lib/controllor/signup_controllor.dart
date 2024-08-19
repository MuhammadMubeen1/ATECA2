

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employe_portal/models/user.dart';
import 'package:employe_portal/themes/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'package:email_otp/email_otp.dart';

class SignupController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();

  Future<void> registerUser(
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController emailController, 
     
    TextEditingController passwordController,
    TextEditingController confirmpassController,
    TextEditingController locationController,
    TextEditingController nationalityController,
    TextEditingController countryController,
    TextEditingController searchController,
    String? selectedPhoneNumber,
    String? phonecode, 
     
    String? completenumber,
    String? selectedState,
    String? profilePicUrl, 
    GlobalKey<FormState> formKey,
    Function(bool) setLoading,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);

      try {
        if (passwordController.text != confirmpassController.text) {
          Fluttertoast.showToast(
            backgroundColor: AppColor.btnColor,
            msg: 'Passwords do not match',
            textColor: Colors.black,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
          );
          setLoading(false);
          return;
        }

      
      

        // Prepare data for Firestore
        int id = DateTime.now().millisecondsSinceEpoch;
        String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String currentTime = DateFormat('h:mm a').format(DateTime.now());
       String platformType = Platform.isAndroid ? 'Android' : 'iOS';
String combinedPhoneNumber = ' ${phonecode}  ${phoneController.text}';
        AddUserModel dataModel = AddUserModel(
          counter: '0',
          name: nameController.text,
          completenumber: combinedPhoneNumber,
          email: emailController.text,
          password: passwordController.text,
          subscription: "unpaid",
          phoneNumber: completenumber,
          restriction: "unrestricted",
          platform: platformType,
          
          verification: "unverified",
          uid: id,
          user: "notdeleted",
          phonecode: phoneController.text,  
          image: profilePicUrl,
          Location: locationController.text,
          Nationality: nationalityController.text,
          State: selectedState,
          date: currentDate,
          time: currentTime,
          firstDate: '',
          nextDueDate: '',
          industeries: searchController.text,
          Countryyy: 'UAE',
        );

        // Save data to Firestore
        await FirebaseFirestore.instance
            .collection("RegisterUse")
            .doc('$id')
            .set(dataModel.toJson());
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Center(
      child: Text(
        "Thank you for registering! Your account is currently under review. An admin will contact you soon once your registration is approved.",
        style:  TextStyle(fontSize: 16.0, color: Colors.white),
        textAlign: TextAlign.center, // Center the text horizontally
      ),
    ),
    duration: const Duration(seconds: 5), // Duration of the Snackbar
    backgroundColor: const Color(0xff2476BD), // Background color
    behavior: SnackBarBehavior.floating, // This allows the Snackbar to float
    margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(
      bottom: MediaQuery.of(context).size.height * 0.5, // Position the Snackbar in the center vertically
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
  ),
);



        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => EmailVerificationScreen()),
          
        // );
      } catch (e) {
        setLoading(false);
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(
              backgroundColor: AppColor.btnColor,
              msg: 'Email is already in use',
              textColor: Colors.black,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
            );
          } else {
            Fluttertoast.showToast(
              backgroundColor: AppColor.btnColor,
              msg: 'Error: ${e.message}',
              textColor: Colors.black,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
            );
          }
        } else {
          Fluttertoast.showToast(
            backgroundColor: AppColor.btnColor,
            msg: 'Some Error Occurred',
            textColor: Colors.black,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
          );
        }
        print(e.toString());
      } finally {
        setLoading(false);
      }
    }
  }

  FutureOr<String?> validatePhoneNumber(PhoneNumber? value) {
    if (value == null || value.number.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }
  

    // Schedule a timer to hide the toast after 10 seconds
}

final List<String> suggestions = [
  "Aerospace & Defense",
  "Arts & Design",
  "Banking",
  "Chemicals",
  "Construction",
  "Consumer Goods",
  "Education",
  "Energy",
  "Engineering",
  "Entertainment",
  "Finance",
  "Food & Beverages",
  "Government Administration",
  "Healthcare",
  "Hospitality",
  "Human Resources",
  "Insurance",
  "Internet",
  "Investment Banking",
  "Investment Management",
  "Journalism",
  "Legal",
  "Manufacturing",
  "Marketing & Advertising",
  "Media Production",
  "Medical Devices",
  "Mental Health Care",
  "Military & Defense",
  "Mining",
  "Music",
  "Non-profit",
  "Oil & Energy",
  "Pharmaceuticals",
  "Public Policy",
  "Real Estate",
  "Recruiting",
  "Renewable Energy",
  "Research",
  "Retail",
  "Software Development",
  "Sports",
  "Telecommunications",
  "Translation & Interpretation",
  "Transportation",
  "Venture Capital"
];

