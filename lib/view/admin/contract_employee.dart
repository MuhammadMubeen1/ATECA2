import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Contact_Document extends StatefulWidget {
  const Contact_Document({super.key});

  @override
  State<Contact_Document> createState() => _Contact_DocumentState();
}

class _Contact_DocumentState extends State<Contact_Document> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text("Contact Document", style:  GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color:Color(0xff2476BD),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),),
        )),


        body:  const  Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Here is the revised text with all duplicate content removed:Contract documents comprise a set of written materials that collectively form a legal agreement between two parties. While the contract itself is a crucial component, its just one part of a larger ensemble of documents, each playing a vital role in defining and clarifying the terms of the agreement.When negotiating a contract, its important to understand that there is a set of documents that are exchanged between the two parties (and multiple participants in each party!), it’s not just the contract.The complete set, including the contract itself, makes up the “contract documents.” Collectively, the contract documents ensure the agreement is comprehensive, clear, and legally binding.'),
        )

    );
  }
}