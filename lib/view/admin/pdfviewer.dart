import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class PdfViewPage extends StatefulWidget {
  final String initialPdfUrl;

  const PdfViewPage({Key? key, required this.initialPdfUrl}) : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  bool _isLoading = true;
  String? _localPath; // Make this nullable

  @override
  void initState() {
    super.initState();
    _loadPdf();
    print('PDF URL: ${widget.initialPdfUrl}');
  }

  Future<void> _loadPdf() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'cached_pdf.pdf'); // Corrected this line

      // Fetch the PDF from Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.refFromURL(widget.initialPdfUrl);
      String url = await ref.getDownloadURL();

      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _localPath = file.path;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff2476BD)),
        title: Center(
          child: Text(
            'PDF Viewer',
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
      body: Center(
        child: _isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator( color:  Color(0xff2476BD)),
                  SizedBox(height: 20),
                  Text('Loading PDF...', style: TextStyle(color:  Color(0xff2476BD),),),
                ],
              )
            : _localPath != null
                ? PDFView(
                    filePath: _localPath!,
                  )
                : const Text('No PDF Found', style: TextStyle(color:  Color(0xff2476BD),),),
      ),
    );
  }
}
