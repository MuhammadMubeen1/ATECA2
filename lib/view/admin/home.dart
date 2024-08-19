
import 'dart:ui';

import 'package:employe_portal/view/admin/contract_employee.dart';
import 'package:employe_portal/view/admin/create_employee.dart';
import 'package:employe_portal/view/admin/pdfviewer.dart';
import 'package:employe_portal/view/admin/update_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home_Screen extends StatefulWidget {

  
  String name, phone , country,address, password, city, salary, contactemail, image, nationality, currance, employer, desination, contactname, contactphone, email, cotactdesination, viewcontract,viewofferletter, viewdocument;
  Home_Screen({
    Key? key,
    required this.name,
    required this.phone,
    required this.country,
    required this.password,
    required this.address,
    required this.city,
    required this.image,
    required this.currance,
    required this.cotactdesination,
    required this.salary,
    required this.nationality,
    required this.email,
    required this.employer,
    required this.desination,
    required this.contactname,
    required this.contactphone,
    required this.contactemail,
    required this.viewcontract,
    required this.viewofferletter,
    required this.viewdocument,
  }) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}
void _launchPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {

      print('viewcontract: ${widget.viewcontract}');
  print('viewofferletter: ${widget.viewofferletter}');
  print('viewdocument: ${widget.viewdocument}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const  IconThemeData(color: Color(0xff2476BD),size: 25),
          centerTitle: true,
          backgroundColor: Colors.white,
             actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon:  const  Icon(Icons.edit, color: Color(0xff2476BD), size: 25,), // Change color as needed
                onPressed: () {
                  // Define the action when the icon is pressed
                 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Update_Employee(
                  name: widget.name.toString(),
                 contractemail: widget.contactemail.toString(),
                  contractname:widget.contactname.toString(),
                   contrdesination:widget.cotactdesination.toString(), 
                   contractphone:widget.contactphone.toString(), salary: widget.salary.toString(), 
                   currency: widget.currance.toString(),
                    employer: widget.employer.toString(),
                     country: widget.country.toString(), image: widget.image,
                      phone: widget.phone.toString(), 
                      address: widget.address.toString(), 
                      password: widget.password.toString(),
                       city:widget.city.toString(), 
                       
                      nationality: widget.nationality.toString(),
                       email: widget.email.toString(), 
                       desination: widget.desination.toString(), 
                       selectcontractdocument: widget.viewcontract.toString(), 
                       offerlatter: widget.viewofferletter.toString(), 
                       oterdocument: widget.viewdocument.toString(),

                
                ),
              ),
            );
                },
              ),
            ),
          ],
          automaticallyImplyLeading: true,
          title: Center(
              child: Text(
            "Welcome",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  color: Color(0xff2476BD),
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Center(
        child: CircleAvatar(
          backgroundImage: (widget.image != null && widget.image.isNotEmpty)
              ? 
          NetworkImage(widget.image ):const AssetImage("assets/images/ateca.png") as ImageProvider,
            
          radius: 70,
        ),
      ),
    
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  ListTile(
                    leading:  const Icon(Icons.person_2_outlined, color: Colors.grey),
                    title: Text(
                      "Name",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                      widget.name?? 'Null Value',
              
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                 
                  const Divider(
                
                  ),
                 ListTile(
                    leading: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                    title: Text(
                      "Email",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                      widget.email ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),


                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 25,
                    ),


                    
                    title: Text(
                      "Phone",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                      widget.phone ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                
                 
                  const Divider(
                   
                  ),
               
              
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                    title: Text(
                      "Address",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                     widget.address ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Divider(),
                 ListTile(
                    leading: const Icon(
                      Icons.location_city,
                      color: Colors.grey,
                      size: 25,
                    ),
                    title: Text(
                      "City",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                     widget.city ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  const Divider(
                 
                  ),
                ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.globe,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    title: Text(
                      "Country",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                    widget.country ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
            const Divider(
                 
                  ),
                  ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.flag,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    title: Text(
                      "Nationality",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                    widget.nationality ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                 
                  const Divider(
                  
                  ),
                  
                  ListTile(
                    leading: const Icon(
                      Icons.work,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Employer",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                   widget.employer ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                
                  Divider(
                    color: Colors.grey.shade500,
                  ),
                 
                  ListTile(
                    leading: const Icon(
                      Icons.person_2,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Designation",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                  widget.desination ?? 'Null Value',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                
                  Divider(
                    color: Colors.grey.shade500,
                  ),
                  
                  ListTile(
                    leading: const Icon(
                      Icons.payment_outlined,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Salary",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    subtitle: Text(
                   
 "${widget.salary ?? 'Salary not provided'} ${widget.currance ?? ''}",

                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                           color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: Colors.grey.shade500,
              ),
            ),
           
            Container(
              height: 200,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      Colors.grey.shade300, // Adjust the border color as needed
                  width: 1, // Adjust the border width as needed
                ), // Adjust the radius as needed
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 18),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/ateca.png',
                          height: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Contact at Ateaca",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                           onTap: () {

                            launchEmail();

                              },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: const Color(0xff2476BD),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                         onTap: () {
            _launchPhoneDialer(widget.contactphone); // Replace with the desired phone number
          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: const Color(0xff2476BD),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                     
                      SizedBox(width: 10,),
                             GestureDetector(
  onTap: () {
    _launchWhatsApp(widget.contactphone); // Call the function to launch WhatsApp
  },
  child: Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      color: const Color(0xff2476BD),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Image.asset("assets/images/whatsapp2.png"),
  ),
),
                     ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          
                          widget.contactname??'',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Color(0xff787878),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                       const SizedBox(height: 8,),
                        Text(
                   widget.cotactdesination??'null value',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Color(0xff787878),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                         widget.contactphone??'null value',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                               color: Color(0xff787878),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                         widget. contactemail??'null valuea',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                               color: Color(0xff787878),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      
                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
Column(
    children: [
      if (widget.viewcontract != null && widget.viewcontract.isNotEmpty) ...[
        GestureDetector(
          onTap: () {
            // Navigate to PDF viewer screen and pass the PDF path
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewPage(initialPdfUrl: widget.viewcontract),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff2476BD),
              borderRadius: BorderRadius.circular(35),
            ),
            width: 242,
            height: 57,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Center(
                  child: Text(
                    'View Contract',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
      if (widget.viewofferletter != null && widget.viewofferletter.isNotEmpty) ...[
        GestureDetector(
          onTap: () {
            // Navigate to PDF viewer screen and pass the PDF path
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewPage(initialPdfUrl: widget.viewofferletter),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff2FDAE4),
              borderRadius: BorderRadius.circular(35),
            ),
            width: 242,
            height: 57,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20), // Adjust the space between the icon and the next widget
                Center(
                  child: Text(
                    'View Offer Letter',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
      if (widget.viewdocument != null && widget.viewdocument.isNotEmpty) ...[
        GestureDetector(
          onTap: () {
            // Navigate to PDF viewer screen and pass the PDF path
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewPage(initialPdfUrl: widget.viewdocument),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffC2C2C2),
              borderRadius: BorderRadius.circular(35),
            ),
            width: 242,
            height: 57,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20), // Adjust the space between the icon and the next widget
                Center(
                  child: Text(
                    'View Document',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
SizedBox(height: 10,),
 Container(

              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
     
   style: ElevatedButton.styleFrom(
  backgroundColor: Colors.red
  ),
                onPressed: () async {
                  bool? confirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:  const Text("Confirm Deletion", style:TextStyle(color: Color(0xff2476BD)) ,),
                        content: const Text(
                            "Are you sure you want to delete this employee?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancel", style:TextStyle(color: Color(0xff2476BD)) ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text("Delete", style:TextStyle(color: Color(0xff2476BD)) ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed == true) {
                    // Delete the document from Firestore
                   try {
  // Query the Firestore collection for the document with the specified email
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('AllEmployees')
      .where('email', isEqualTo: widget.email)
      .get();

  // Delete each document found
  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    await doc.reference.delete();
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      
      backgroundColor: Color(0xff2476BD),
      content: Text('Employee deleted successfully.', style: TextStyle(color: Colors.white ),),
    ),
  );

  Navigator.pop(context); // Return to the previous screen
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
         backgroundColor: Color(0xff2476BD),
      content: Text('Failed to delete employee: $e', style: TextStyle(color: Colors.white),),
    ),
  );
}

               
  }
  },
   child: const Text("Remove Employee", style: TextStyle(color: Colors.white),)
   ),
            ),
          ],
        
      
      
    
  
           const SizedBox(height: 50,
           )
          ],
        ),
      ]),
     ) );
  }
dynamic launchEmail() async {
  try{
    Uri email = Uri(
      scheme: 'mailto',
      path: widget.contactemail,
      queryParameters: {
        'subject': "Write your feedback"
      },
    );
    await launchUrl(email);
  }
  catch(e) {
    debugPrint(e.toString());
  }
}

  void _launchWhatsApp(String phoneNumber) async {
  String message = 'Hello!'; // Your message here
  String url = 'https://wa.me/$phoneNumber/?text=${Uri.parse(message)}';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch WhatsApp';
  }
}
}
