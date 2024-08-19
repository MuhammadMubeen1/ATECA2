
import 'dart:async';
import 'dart:io';
import 'dart:math';




import 'package:country_picker/country_picker.dart';
import 'package:email_otp/email_otp.dart';
import 'package:employe_portal/controllor/signup_controllor.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:employe_portal/themes/color.dart';
import 'package:employe_portal/view/admin/login_screen.dart';
import 'package:employe_portal/widgetss/country_picker.dart';
import 'package:employe_portal/widgetss/dropdown_button.dart';
import 'package:employe_portal/widgetss/reusable_button.dart';
import 'package:employe_portal/widgetss/reusable_text.dart';
import 'package:employe_portal/widgetss/reusable_textformfield.dart';
import 'package:employe_portal/widgetss/reuseable_dropdown.dart';
import 'package:employe_portal/widgetss/textfield2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';






class Signup extends StatefulWidget {
  String email;
   Signup({Key? key, required this.email}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  TextEditingController Nationalitycontroller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController CountryControllor = TextEditingController();
  TextEditingController Searchcontrollor = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SignupController _signupController = SignupController();
 

void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    Nationalitycontroller.dispose();
    locationController.dispose();
    CountryControllor.dispose();
    Searchcontrollor.dispose();
    _scrollController.dispose();
  
    super.dispose();
  }


   final TextEditingController _phoneController = TextEditingController();
 

  bool _passwordVisible = false;
  bool passwordVisible = false;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();
  String? industeries;
  String? completenumber;
   String profilePicUrl = "";
  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
 
  @override
  void initState() {
  
    super.initState();
  }

  int suggestionsCount = 21; // Initial count of suggestions
  int counter = 0;
  String? _selectedState;
 String countryCode = "+971";
  final _formKey = GlobalKey<FormState>();
  
    FocusNode fullName = FocusNode(); 
    FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
    FocusNode locationFocusNode = FocusNode();
         FocusNode CitNode = FocusNode();
            FocusNode NationalityNode = FocusNode();
               FocusNode expertiesNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  ///country code of the code
  
    String? selectedPhoneNumber ;
     PickedFile? imageFile;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              controller:_scrollController,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                      const SizedBox(height: 10),
                 const ReusableText(
                  title: "Sign Up",
                  color: Color(0xff2476BD),
                  size: 27,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 20),

               GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => openGallery()),
                    );
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(600),
                          child: Container(
                            height: 180,
                            width: 180,
                            child: (imageFile != null)
                                ? Image.file(
                                    File(imageFile!.path),
                                    fit: BoxFit.cover,
                                  )
                                : (profilePicUrl.isEmpty
                                    ? Image.asset(
                                        'assets/images/ateca.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        profilePicUrl,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => openGallery()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color:  Color(0xff2476BD),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
               
           
                ReusableTextForm(
                onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(phoneFocusNode);
                    },
                  focusNode: fullName,
                  controller: nameController,
                  hintText: "Full Name",
               
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.person_outlined,
                    color: AppColor.hintColor,
                  ),
                ),
             Row(
               children: [

                 CountryCodePicker(
                  showDropDownButton: true,
                    onChanged: (country){
                      setState(() {
                       countryCode = country.dialCode!;
                       completenumber =country.code;
                      });
                    },
                    initialSelection: "AE",
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: ["+971", "AE", ],
                  ),
            
               ],
             ),
            

  TextFormField(
        focusNode: phoneFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(emailFocusNode);
        },
        decoration: InputDecoration(
          hintText: "Phone Number",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefix: Padding(
            padding: EdgeInsets.all(4),
            child: Text(countryCode),
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const  BorderSide(color: AppColor.borderFormColor, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const  BorderSide(color: Colors.red, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const   BorderSide(color: Colors.red, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColor.borderFormColor, width: 1),
          ),
          contentPadding:const  EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        ),
       
        keyboardType: TextInputType.number,
        controller: phoneController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      
      ),
    



               



                const SizedBox(
                  height: 10,
                ),
                 ReusableTextForm2 (
                    focusNode: emailFocusNode,
              onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(locationFocusNode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    controller: emailController,
                    hintText: "Email",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "This field is required";
                      } else if (!v.contains("@")) {
                        return "Email badly formatted";
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColor.hintColor,
                    ), 
                  ),
                const SizedBox(height: 20),
                 ReusableTextForm2 (
                  
                   focusNode: locationFocusNode,
              onSubmitted: (_) {
                     FocusScope.of(context).requestFocus(CitNode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    controller: locationController,
                    hintText: "Address",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "This field is required";
                      
                        
                      }
                    },
                    prefixIcon: const Icon(
                       Icons.location_on_outlined,
                      color: AppColor.hintColor,
                    ), 
                  ),
                
                 const SizedBox(height: 20),
                ReusableDropdown(
                  
                onSubmitted: () {
                    FocusScope.of(context).requestFocus(NationalityNode);
                },
                focusNode: CitNode,
                         selectedValue: _selectedState,
                  hint: 'City',
                  
                  prefixIcon: const   Icon(
                    Icons.location_city_outlined,
                    color: AppColor.hintColor,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "This field is required";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    style:const TextStyle(color: AppColor.hintColor),
                    controller: CountryControllor,
                    readOnly: true,
                    decoration: InputDecoration(
                       contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0), 
                      fillColor:
                          Colors.white, // Ensure the fillColor is set to white
                      filled: true, // Set the filled property to true
                      hintText: 'UAE',
                      
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 13, left: 12),
                        child: FaIcon(
                          FontAwesomeIcons.globe,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:  BorderSide( color: Colors.grey.shade300,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:  BorderSide( color: Colors.grey.shade300,),
                      ),
                    ),
                    onTap: () {}),
                const SizedBox(
                  height: 20,
                ),
                ReusableCountryPickerFormField(
                  controller: Nationalitycontroller,
                  hintText: 'Nationality',
                  
                  
                  
                  onSelect: (Country country) {
                    setState(() {
                      String countryName = country.name;
                      Nationalitycontroller.text = countryName;
                    });
                    print('Selected country: ${country.name}');
                  },
                ),
                const SizedBox(height: 20),
                CustomSearchField(

                  focusNode: expertiesNode,
               onSubmitted: (String value) {
                 FocusScope.of(context).requestFocus(passwordFocusNode);
  },
                  suggestions: suggestions,
                  
                  hint: 'Search industries...',
                  onSuggestionAdded: () {
                    setState(() {
                      suggestionsCount++;
                      counter++;
                      suggestions.add('suggestion $suggestionsCount');
                    });
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    color: AppColor.hintColor,
                  ),
                  controller: Searchcontrollor,
                ),
                const SizedBox(height: 20),
                ReusableTextForm(
                  focusNode: passwordFocusNode,
                  onSubmitted:   (_) {
                      FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                    },
                  textCapitalization: TextCapitalization.none,
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: !_passwordVisible,
                  suffixIcon: IconButton(
                    // Toggle icon based on password visibility
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xff2476BD),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Password Should Not Be Empty";
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: AppColor.hintColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReusableTextForm(
                  focusNode: confirmPasswordFocusNode,
                  textCapitalization: TextCapitalization.none,
                  controller: confirmpassController,
                  hintText: " Confirm Password",
                  obscureText: !passwordVisible,
                  suffixIcon: IconButton(
                    // Toggle icon based on password visibility
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color:const Color(0xff2476BD),
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Confirm Password Should Not Be Empty";
                    } else if (v != passwordController.text) {
                      return "Passwords do not match";
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: AppColor.hintColor,
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Color(0xff2476BD))
                    :ReusableButton(
  title: "Register",
  onTap: () async {
    if (_formKey.currentState!.validate()) {
  if (imageFile == null) {
                                Fluttertoast.showToast(
                                  msg: "Please select a profile picture",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Color(0xff2476BD),
                                  fontSize: 16.0,
                                );
                                return;
                              }

      setLoading(true); // Start loading
      await uploadProfilePic(); // Upload profile picture
      await _signupController.registerUser(
        nameController,
        phoneController,
        emailController,
        passwordController,
        confirmpassController,
        locationController,
        Nationalitycontroller,
        CountryControllor,
        Searchcontrollor,
        selectedPhoneNumber,
        countryCode,
        completenumber,
        _selectedState,
        profilePicUrl,
        _formKey,
        setLoading,
        context,
      );
      setLoading(false); 
       Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login_Screen (),
                                    ),
                                  );// Stop loading
    }
  
  
  },
),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ReusableText(
                      title: "Already have an account?",
                      color: AppColor.textColor,
                      weight: FontWeight.normal,
                    ),
                      const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  Login_Screen ()),
                        );
                      },
                      child: const Center(
                        child: ReusableText(
                          title: "Sign In",
                          color: Color(0xff2476BD),
                          weight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
  


                const SizedBox(
                  height: 15,
                ),
              
            ])),
          ),
        ),
      ),
    );
  }
    Widget openGallery() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose profile photo",
            style: TextStyle(
                color: Color(0xff2476BD), fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Text("Camera "),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: Color(0xff2476BD),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Text(
                      "Gallery ",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.image, color:Color(0xff2476BD)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  Future<void> uploadProfilePic() async {
  if (imageFile != null) {
    final storageRef = FirebaseStorage.instance.ref();
    final profilePicRef = storageRef.child('profilePics/${DateTime.now().toString()}');
    await profilePicRef.putFile(File(imageFile!.path));
    profilePicUrl = await profilePicRef.getDownloadURL();
  }
}

 String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    final phoneNumber = RegExp(r'^\d{10,12}$'); // Example for 10-12 digits
    if (!phoneNumber.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}



