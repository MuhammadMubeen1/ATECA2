import 'package:employe_portal/view/admin/login_screen.dart';
import 'package:employe_portal/view/admin/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class User_Info extends StatefulWidget {
  final String currentEmail;

  User_Info({required this.currentEmail});

  @override
  State<User_Info> createState() => _User_InfoState();
}

class _User_InfoState extends State<User_Info> {
  var emerphone;
  var employer;
  var emercompanyEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        leading: IconButton(
  icon: const Icon(
    Icons.logout,
    color: Color(0xff2476BD),
    size: 25,
  ),
  onPressed: () async {
    // Show a confirmation dialog
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout', style: TextStyle(color:  Color(0xff2476BD, ), fontWeight: FontWeight.bold),),
          content: const Text('Are you sure you want to logout?', style: TextStyle(color:  Colors.black, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color:  Color(0xff2476BD),  fontWeight: FontWeight.bold), ),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false when cancel is pressed
              },
            ),
            TextButton(
              child: const  Text('Logout',style: TextStyle(color:  Color(0xff2476BD),  fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true when logout is confirmed
              },
            ),
          ],
        );
      },
    );

    // If user confirms logout, clear SharedPreferences and navigate to login screen
    if (confirmLogout ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all SharedPreferences

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login_Screen()),
        (Route<dynamic> route) => false, // Prevent going back to previous screen
      );
    }
  },
),
     
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome",
          style: TextStyle(
              color: Color(0xff2476BD),
              fontSize: 20), // Optional: to change the text color
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('AllEmployees')
              .where('email', isEqualTo: widget.currentEmail)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            var docSnapshot = snapshot.data!.docs.first;

            var address = docSnapshot.get('address');
            var contractDocumentUrl = docSnapshot.get('contractDocumentUrl');
            var country = docSnapshot.get('country');
            var city = docSnapshot.get('city');
            var currency = docSnapshot.get('currency');
            var date = docSnapshot.get('date');
            var designation = docSnapshot.get('designation');
            var email = docSnapshot.get('email');
            emercompanyEmail = docSnapshot.get('emergencyContact.companyemail');
            var emerdesignation =
                docSnapshot.get('emergencyContact.designation');
            var emername = docSnapshot.get('emergencyContact.name');
            emerphone = docSnapshot.get('emergencyContact.phone');
            employer = docSnapshot.get('employer');
            var imageUrl = docSnapshot.get('imageUrl');
            var name = docSnapshot.get('name');
            var nationality = docSnapshot.get('nationality');
            var offercontractUrl = docSnapshot.get('offercontractUrl');
            var otherdoc = docSnapshot.get('otherdoc');
            var password = docSnapshot.get("password");
            var phone = docSnapshot.get('phone');
            var salary = docSnapshot.get('salary');

            return SingleChildScrollView(
              child: Column(
                children: [
             CircleAvatar(
                  backgroundImage:
                      (imageUrl != null && imageUrl.isNotEmpty)
                          ? NetworkImage(imageUrl as String)
                              as ImageProvider<Object>?
                          : const AssetImage("assets/images/ateca.png")
                              as ImageProvider<Object>?,
                  radius: 70,
                ),

                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.person_2_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
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
                            name ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                            size: 30,
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
                            email ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 30,
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
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, 'Phone', phone, (value) {
                                setState(() {
                                  phone = value;
                                });
                                _updateField('phone', value);
                              });
                            },
                          ),
                          subtitle: Text(
                            phone ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(context, 'Address', address,
                                  (value) {
                                setState(() {
                                  address = value;
                                });
                                _updateField('address', value);
                              });
                            },
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
                            address ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.city,
                            color: Colors.grey,
                            size: 20.0,
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
                            city ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
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
                            country ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
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
                            nationality ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
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
                            employer ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
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
                            designation ?? 'Null Value',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        const Divider(),
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
                            "${salary ?? 'Salary not provided'} ${currency ?? ''}",
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
                  const Divider(),
                  Container(
                    height: 200,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors
                            .grey.shade300, // Adjust the border color as needed
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
                                  _launchPhoneDialer(
                                      emerphone); // Replace with the desired phone number
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
    _launchWhatsApp( emerphone); // Call the function to launch WhatsApp
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
                                emername,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Color(0xff787878),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            const   SizedBox(
                                height: 8,
                              ),
                              Text(
                                emerdesignation ?? 'null value',
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
                                emerphone ?? 'null value',
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
                                emercompanyEmail,
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
    if (contractDocumentUrl != null)
      GestureDetector(
        onTap: () {
          // Navigate to PDF viewer screen and pass the PDF path
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewPage(initialPdfUrl: contractDocumentUrl),
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
          child: const Center(
            child: Text(
              'View Contract',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    if (contractDocumentUrl != null) const SizedBox(height: 10),
    if (offercontractUrl != null)
      GestureDetector(
        onTap: () {
          // Navigate to PDF viewer screen and pass the PDF path
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewPage(initialPdfUrl: offercontractUrl),
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
          child: const Center(
            child: Text(
              'View Offer Letter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    if (offercontractUrl != null) const SizedBox(height: 10),
    if (otherdoc != null)
      GestureDetector(
        onTap: () {
          // Navigate to PDF viewer screen and pass the PDF path
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewPage(initialPdfUrl: otherdoc),
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
          child: const Center(
            child: Text(
              'View Document',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
  ],
),


                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            );
          }),
    );
  }

  dynamic launchEmail() async {
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: emercompanyEmail,
        queryParameters: {'subject': "Write your feedback"},
      );
      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _launchPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: emerphone,
    );
    await launchUrl(launchUri);
  }

  Future<void> _showEditDialog(BuildContext context, String fieldName,
      String currentValue, Function(String) onSave) async {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $fieldName'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter new $fieldName:'),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter $fieldName',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateField(String fieldName, String newValue) async {
    try {
      // Retrieve the document based on the email condition
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('AllEmployees')
          .where('email', isEqualTo: widget.currentEmail)
          .get();

      // Ensure a document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String docId = querySnapshot.docs.first.id;

        // Update the field in the retrieved document
        await FirebaseFirestore.instance
            .collection('AllEmployees')
            .doc(docId)
            .update({fieldName: newValue});
      } else {
        print('No document found for the provided email.');
      }
    } catch (e) {
      print('Error updating $fieldName: $e');
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
