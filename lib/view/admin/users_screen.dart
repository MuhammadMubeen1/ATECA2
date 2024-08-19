



import 'package:employe_portal/view/admin/create_employee.dart';
import 'package:employe_portal/view/admin/home.dart';
import 'package:employe_portal/view/admin/login_screen.dart';
import 'package:employe_portal/view/admin/registeruser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class aUsers extends StatefulWidget {
  const aUsers({Key? key}) : super(key: key);

  @override
  State<aUsers> createState() => _aUsersState();
}

class _aUsersState extends State<aUsers> {
  late DateTime _selectedDate;
  bool _showAllUsers = true;
  TextEditingController _searchController = TextEditingController();
    TextEditingController _searchController2 = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
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
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          color: Color(0xff2476BD),
                          fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color(0xff2476BD),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false); // Cancel logout
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              color: Color(0xff2476BD),
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true); // Confirm logout
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
                  (Route<dynamic> route) => false, // Prevent going back
                );
              }
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Employees",
            style: TextStyle(
                color: Color(0xff2476BD),
                fontSize: 20), // Optional: to change the text color
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Color(0xff2476BD),
                  size: 30,
                ), // Change color as needed
                onPressed: () {
                  // Define the action when the icon is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Create_Employee(),
                    ),
                  );
                },
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor:Color(0xff2476BD),
            indicatorColor: Color(0xff2476BD), // Tab indicator color
            tabs: [
              Tab(
                
                text: 'Approved Employees',
              
              ),
              Tab(
                text: 'Register Employee',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildApprovedEmployeesTab(),
             buildApprovedregEmployeesTab()
            
          ],
        ),
      ),
    );
  }

  Widget buildApprovedEmployeesTab() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            cursorColor: Color(0xff2476BD),
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              hintText: 'Search by name or email.',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0)
                  // Rounded corners
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0), // Rounded corners
                borderSide: const BorderSide(
                  color: Color(0xff2476BD),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0), // Rounded corners
                borderSide: const BorderSide(
                  color: Color(0xff2476BD), // Change the color as needed
                ),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xff2476BD),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('AllEmployees').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var documents = snapshot.data!.docs;

            // Filter documents based on search query
            var filteredDocuments = documents.where((document) {
              var name = document['name'].toString().toLowerCase();
              var email = document['email'].toString().toLowerCase();
              return name.contains(_searchQuery) ||
                  email.contains(_searchQuery);
            }).toList();

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Total Employees: ${filteredDocuments.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2476BD),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: _buildUserList(filteredDocuments)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

Widget buildApprovedregEmployeesTab() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            cursorColor: Color(0xff2476BD),
            controller:  _searchController2,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              hintText: 'Search by name or email.',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0)
                  // Rounded corners
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0), // Rounded corners
                borderSide: const BorderSide(
                  color: Color(0xff2476BD),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0), // Rounded corners
                borderSide: const BorderSide(
                  color: Color(0xff2476BD), // Change the color as needed
                ),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xff2476BD),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('RegisterUse').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var documents = snapshot.data!.docs;

            // Filter documents based on search query
            var filteredDocuments = documents.where((document) {
              var name = document['name'].toString().toLowerCase();
              var email = document['email'].toString().toLowerCase();
              return name.contains(_searchQuery) ||
                  email.contains(_searchQuery);
            }).toList();

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Total Register Employee: ${filteredDocuments.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2476BD),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: _buildUsersList(filteredDocuments)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  }

  Widget _buildUserList(List<QueryDocumentSnapshot> documents) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        var document = documents[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home_Screen(
                  city: document['city'].toString(),
                  password: document['password'].toString(),
                  country: document['country'].toString(),
                  image: document['imageUrl'].toString(),
                  contactemail:
                      document['emergencyContact']['companyemail'].toString(),
                  name: document['name'].toString(),
                  currance: document['currency'].toString(),
                  salary: document['salary'].toString(),
                  phone: document['phone'].toString(),
                  address: document['address'].toString(),
                  nationality: document['nationality'].toString(),
                  employer: document['employer'].toString(),
                  desination: document['designation'].toString(),
                  contactname: document['emergencyContact']['name'].toString(),
                  contactphone:
                      document['emergencyContact']['phone'].toString(),
                  viewcontract:
                      document['contractDocumentUrl'].toString(),
                  viewofferletter:
                      document['offercontractUrl'].toString(),
                  viewdocument: document['otherdoc'].toString(),
                  cotactdesination: document['emergencyContact']
                          ['designation']
                      .toString(),
                  email: document['email'].toString(),
                ),
              ),
            );
          },
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: (document['imageUrl'] != null &&
                          document['imageUrl']!.isNotEmpty)
                      ? NetworkImage(document['imageUrl'] as String)
                          as ImageProvider<Object>?
                      : const AssetImage("assets/images/ateca.png"),
                  radius: 25,
                ),
                title: Text(
                  document['name']??"",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  document['email']??'',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xff2476BD),
              ),
            ],
          ),
        );
      },
    );




  }
Widget _buildUsersList(List<QueryDocumentSnapshot> documents) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        var document = documents[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Userprofile(
                
                  image: document['image'].toString(),
                  phone: document['completenumber'].toString(), email: document['email'], Verified: '', state: document['State'], location:document['Location'], Nationality: 'Nationality', username: 'name', industeries: 'industeries', countrrr: 'Countryyy',
               
                 
            
                
                 
                  
                ),
              ),
            );
          },
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: (document['image'] != null &&
                          document['image']!.isNotEmpty)
                      ? NetworkImage(document['image'] as String)
                          as ImageProvider<Object>?
                      : const AssetImage("assets/images/ateca.png"),
                  radius: 25,
                ),
                title: Text(
                  document['name']??'',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  document['email']??'',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xff2476BD),
              ),
            ],
          ),
        );
      },
    );}
