import 'dart:io';
import 'package:employe_portal/widgetss/country_picker.dart';
import 'package:employe_portal/widgetss/custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_format/date_format.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:shortid/shortid.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mailer/smtp_server/gmail.dart';



 

class Create_Employee extends StatefulWidget {
  const Create_Employee({super.key});

  @override
  State<Create_Employee> createState() => _Create_EmployeeState();
}

class _Create_EmployeeState extends State<Create_Employee> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
    final TextEditingController city_controllor = TextEditingController();
  final TextEditingController employerController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
    final TextEditingController passwordController= TextEditingController();
  final TextEditingController contactDesignationController =
      TextEditingController();
  final TextEditingController contacttextEditingController =
      TextEditingController();
  final TextEditingController OfferLatterController = TextEditingController();
  final TextEditingController otherLatterController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();

    countryController.dispose();

    nationalityController.dispose();
    designationController.dispose();
    employerController.dispose();
    salaryController.dispose();
    currencyController.dispose();
    contactNameController.dispose();
    contactDesignationController.dispose();
    OfferLatterController.dispose();
    otherLatterController.dispose();
    super.dispose();
  }
  bool _passwordVisible = false;
  PlatformFile? pickedFile;
  PlatformFile? pickedFile2;
  PlatformFile? pickedFile3;
  String? phoneNumber;
  String? contactPhoneNumber;
  File? _image;
  bool isLoading = false;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null;
    String fileName =
        'All Employees/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    try {
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _pickImage2(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage2() async {
    if (_image == null) return null;
    String fileName =
        'All Employees/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    try {
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _pickImage3(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage3() async {
    if (_image == null) return null;
    String fileName =
        'All Employees/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    try {
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:  Color(0xff2476BD), size: 25),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Center(
          child: Text( 
            "Create Employee",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Color(0xff2476BD),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
       
        ),
       
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                      onClosing: () {},
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera, color: Color(0xff2476BD),),
                            title: const Text('Camera'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading:const Icon(Icons.photo_album, color: Color(0xff2476BD),),
                            title: const Text('Gallery',),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          :const  AssetImage("assets/images/ateca.png")
                              as ImageProvider,                      radius: 70,
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.camera_alt,
                       color: Color(0xff2476BD),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                prefixIcon:
                    const Icon(Icons.person_2_outlined, color: Colors.grey),
                hintText: 'Name',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                prefixIcon:
                   Icon(Icons.email_outlined, color:  Colors.grey.shade300),
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    // Optionally, add more validation for email format
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }}
              ),
              const SizedBox(height: 10),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25),
  child: TextFormField(
  
    textCapitalization: TextCapitalization.none,
    controller: passwordController,
    decoration: InputDecoration(
      hintText: "Password",
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
      suffixIcon: IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
       
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
      prefixIcon: const Icon(
        Icons.password_outlined,
         color: Colors.grey,
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

 const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IntlPhoneField(
                  
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Phone",
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xff999CAD),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                 validator: (value) {
                  if (value == null) {
                    return 'Please select a address';
                  }
                  return null;
                },
                  initialCountryCode: 'AE',
                  onChanged: (phone) {
                    setState(() {
                      phoneNumber = phone.completeNumber;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: 'Address',
                prefixIcon:
                    const Icon(Icons.location_on_outlined, color: Colors.grey),
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a address';
                  }
                  return null;
                },
              ),
const SizedBox(height: 20,),
 CustomTextFormField(
                hintText: 'City',
                prefixIcon:
                    const Icon(Icons.location_city, color: Colors.grey),
                controller: city_controllor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a address';
                  }
                  return null;
                },
              ),


              const SizedBox(height: 10),
              CustomTextFormField(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(top: 13, left: 12),
                  child: FaIcon(FontAwesomeIcons.globe,
                      color: Colors.grey, size: 20.0),
                ),
                hintText: 'Country',
                controller: countryController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Container(width: 300,
                child: ReusableCountryPickerFormField(
                  controller: nationalityController,
                  hintText: 'Nationality',
                  onSelect: (Country country) {
                    setState(() {
                      nationalityController.text = country.name;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.person_2, color: Colors.grey),
                hintText: 'Designation',
                controller: designationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.work, color: Colors.grey),
                hintText: 'Employer',
                controller: employerController,
                validator: (value) {
                  if (value == null) {
                    return 'this field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: TextFormField(
                      readOnly: true,
                      controller: contacttextEditingController,
                      decoration: InputDecoration(
                        hintText: ' Select Contract Document ',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        suffixIcon:const  Icon(Icons.attach_file),
                        // Default border style
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            // Adjust width as needed
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        // Focused border style
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),  
                                                  borderSide: BorderSide(
                            color:
                                Colors.grey.shade300, // Adjust color as needed
                            // Adjust width as needed
                          ),
                        ),
                        // Error border style
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.red, // Adjust color as needed
                            width: 2.0, // Adjust width as needed
                          ),
                        ),
                        // Border style when disabled
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            // Adjust width as needed
                          ),
                        ),
                      ),
                        onTap: () async {
            // Open file picker
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null) {
              pickedFile = result.files.first;
              // Check file size (size is in bytes, 1024 bytes = 1 KB, 1024 * 1024 bytes = 1 MB)
             if (pickedFile!.size <= 500 * 1024) { // 100 KB limit
                setState(() {
            contacttextEditingController.text = pickedFile!.name;
                });
              } else {
                // Show error if file size exceeds the limit
                ScaffoldMessenger.of(context).showSnackBar(
                 const  SnackBar(
                  backgroundColor: Color(0xff2476BD),
                    content: Text('File size should be less than 500 KB, Please compress before upload.'),
                  ),
                );
              }
            }
          
                      }),
                ),
              ),
             const SizedBox(
                height: 20,
              ),
          Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: TextFormField(
          readOnly: true,
          controller: OfferLatterController,
          decoration: InputDecoration(
            hintText: ' Upload Offer Letter ',
            hintStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            suffixIcon: Icon(Icons.attach_file),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(18.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          onTap: () async {
            // Open file picker
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null) {
              pickedFile2 = result.files.first;
              // Check file size (size is in bytes, 1024 bytes = 1 KB, 1024 * 1024 bytes = 1 MB)
             if (pickedFile2!.size <= 500 * 1024) { // 100 KB limit
                setState(() {
                OfferLatterController.text = pickedFile2!.name;
                });
              } else {
                // Show error if file size exceeds the limit
                ScaffoldMessenger.of(context).showSnackBar(
                 const  SnackBar(
                   backgroundColor: Color(0xff2476BD),
                    content: Text('File size should be less than 500 KB, Please compress the file before upload.'),
                  ),
                );
              }
            }
          },
        ),
      ),
    ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: TextFormField(
                      readOnly: true,
                      controller: otherLatterController,
                      decoration: InputDecoration(
                        hintText: ' Upload Other Document ',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.attach_file),
                        // Default border style
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            // Adjust width as needed
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        // Focused border style
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color:
                                Colors.grey.shade300, // Adjust color as needed
                            // Adjust width as needed
                          ),
                        ),
                        // Error border style
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.red, // Adjust color as needed
                            width: 2.0, // Adjust width as needed
                          ),
                        ),
                        // Border style when disabled
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            // Adjust width as needed
                          ),
                        ),
                      ),
                    onTap: () async {
            // Open file picker
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null) {
              pickedFile3 = result.files.first;
              // Check file size (size is in bytes, 1024 bytes = 1 KB, 1024 * 1024 bytes = 1 MB)
             if (pickedFile3!.size <= 500 * 1024) { // 100 KB limit
                setState(() {
          otherLatterController.text = pickedFile3!.name;
                });
              } else {
                // Show error if file size exceeds the limit
                ScaffoldMessenger.of(context).showSnackBar(
                 const  SnackBar(
                   backgroundColor: Color(0xff2476BD),
                    content: Text('File size should be less than 500 KB, Please compress file before select.'),
                  ),
                );
              }
            }})
                ),
              ),
            const   SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                              Icons.currency_exchange_outlined,
                              color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Salary',
                          hintStyle: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18.0)),
                          ),
                        ),
                        controller: salaryController,
                        validator: (value) {
                          if (value == null) {
                            return 'this field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.payment_outlined,
                              color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Currency',
                          hintStyle: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18.0)),
                          ),
                        ),
                        controller: currencyController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Point of Contact at Ateaca',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xff2476BD),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                hintText: 'Contact Name',
                prefixIcon:
                    const Icon(Icons.person_2_outlined, color: Colors.grey),
                controller: contactNameController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                hintText: 'Contact Email',
                prefixIcon:
                    const Icon(Icons.email_outlined, color: Colors.grey),
                controller: contactEmailController,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Contact Phone",
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xff999CAD),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  initialCountryCode: 'AE',
                  onChanged: (phone) {
                    setState(() {
                      contactPhoneNumber = phone.completeNumber;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                hintText: 'Contact Designation',
                prefixIcon: const Icon(Icons.design_services_outlined,
                    color: Colors.grey),
                controller: contactDesignationController,
              ),
              const SizedBox(height: 30),
        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24.0),
  child: Container(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff2476BD),
        textStyle: const TextStyle(fontSize: 18),
        minimumSize: const Size.fromHeight(55),
      ),
      onPressed: isLoading
          ? null // Disable button if loading
          : () async {
              if (_image == null) {
                Fluttertoast.showToast(
                  msg: "Please select an image.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Color(0xff2476BD),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return; // Stop execution if no image is selected
              }

              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true; // Set isLoading to true immediately
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

                await _createEmployee();

                setState(() {
                  isLoading = false; // Set isLoading to false after completion
                });
              }
            },
      child: isLoading
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
              "Create Employee",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    ),
  ),
),

              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

Future<void> _createEmployee() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    // Create user with email and password
    // UserCredential user = await _auth.createUserWithEmailAndPassword(
    //   email: emailController.text,
    //   password: passwordController.text,
    // );

    // Upload images and files concurrently
    final List<Future<String?>> uploadFutures = [
      _uploadImage(),
      if (pickedFile != null) _uploadFile(pickedFile!),
      _uploadImage2(),
      if (pickedFile2 != null) _uploadFile(pickedFile2!),
      _uploadImage3(),
      if (pickedFile3 != null) _uploadFile(pickedFile3!),
    ];

    // Wait for all uploads to complete
    final List<String?> uploadResults = await Future.wait(uploadFutures);

    String? imageUrl = uploadResults.isNotEmpty ? uploadResults[0] : null;
    String? fileUrl = pickedFile != null && uploadResults.length > 1 ? uploadResults[1] : null;
    String? imageUrl2 = pickedFile != null && uploadResults.length > 2 ? uploadResults[2] : null;
    String? fileUrl2 = pickedFile2 != null && uploadResults.length > 3 ? uploadResults[3] : null;
    String? imageUrl3 = pickedFile2 != null && uploadResults.length > 4 ? uploadResults[4] : null;
    String? fileUrl3 = pickedFile3 != null && uploadResults.length > 5 ? uploadResults[5] : null;

    int id = DateTime.now().millisecondsSinceEpoch;
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String email = emailController.text.trim();

    // Send confirmation email
    bool emailSent = await sendEmail(email, nameController.text, id.toString(), passwordController.text);

    // If email is sent successfully, add the employee data to Firestore
    if (emailSent) {
      await FirebaseFirestore.instance.collection('AllEmployees').add({
        'name': nameController.text,
        'email': emailController.text,
        'date': currentDate,
        'city': city_controllor.text,
        'imageUrl': imageUrl,
        'phone': phoneNumber, // Replace with your phone number variable
        'contractDocumentUrl': fileUrl,
        'offercontractUrl': fileUrl2,
        'otherdoc': fileUrl3,
        'password': passwordController.text,
        'address': addressController.text,
        'country': countryController.text,
        'nationality': nationalityController.text,
        'designation': designationController.text,
        'employer': employerController.text,
        'salary': salaryController.text,
        'currency': currencyController.text,
        'uid': id,
        'emergencyContact': {
          'name': contactNameController.text,
          'companyemail': contactEmailController.text,
          'phone': contactPhoneNumber, // Replace with your contact phone number variable
          'designation': contactDesignationController.text,
        },
      });

      // Clear the form fields and show success message
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Employee created and email sent successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff2476BD),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Employee creation failed as email sending failed. Please write correct email.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    // Handle error (e.g., show error message)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $e',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<String?> _uploadFile(PlatformFile file) async {
  try {
    final fileRef = FirebaseStorage.instance
        .ref()
        .child('contract_documents/${file.name}');
    final uploadTask = fileRef.putFile(File(file.path!));
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print('File upload error: $e');
    return null;
  }
}

Future<bool> sendEmail(String recipientEmail, String recipientName, String employeeId, String ispassword) async {
  try {
    // Generate a unique ID
    var uuid = Uuid();
    String uniqueId = uuid.v1();
    String shortUniqueId = shortid.generate();
    String username = 'almubeen104@gmail.com';
    String password = 'qsyjoxjhbqhrtids';
    final smtpServer = gmail(username, password);

    final message = mailer.Message()
      ..from = mailer.Address(username)
      ..recipients.add(recipientEmail)
      ..subject = "Employee Creation Confirmation by Ateca"
      ..html = "<p>Dear $recipientName,</p>"
          "<p>Welcome to Ateca</p>"
          "<p>We have successfully created an employee record for you. (ID: $employeeId)</p>"
              "<p>Your account email is (Email: $recipientEmail)</p>"
              "<p>Your account Password is (Password: $ispassword)</p>"
              "<p> Please login on Ateca Employee Portal and give your feedback. </p>" 
          "<p>Thank you for joining us!</p>"
          "<p>Ateca Team</p>";  

    final sendReport = await mailer.send(message, smtpServer);
    print('Message sent: $sendReport');
    return true;
  } catch (error) {
    print('Error sending email: $error');
    return false;
  }
} 

}
