import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class UpdateAllUsersScreen extends StatefulWidget {
  @override
  _UpdateAllUsersScreenState createState() => _UpdateAllUsersScreenState();
}

class _UpdateAllUsersScreenState extends State<UpdateAllUsersScreen> {
  final TextEditingController _newFieldController = TextEditingController();

  Future<void> updateAllUsers(String newFieldValue) async {
    CollectionReference users = FirebaseFirestore.instance.collection('RegisterUsers');

    try {
      QuerySnapshot querySnapshot = await users.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        batch.update(doc.reference, {'user': newFieldValue});
      }

      await batch.commit();
      print("All users updated successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All users updated successfully')),
      );
    } catch (error) {
      print("Failed to update users: $error");
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update users: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update All Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _newFieldController,
              decoration:const  InputDecoration(labelText: 'New Field Value'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newFieldValue = _newFieldController.text.trim();
                if (newFieldValue.isNotEmpty) {
                  updateAllUsers(newFieldValue);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a value')),
                  );
                }
              },
              child:const  Text("Update All Users"),
            ),
          ],
        ),
      ),
    );
  }
}
