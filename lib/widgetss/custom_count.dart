
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';

// Import your country picker package

class ReusableCountryPickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(Country) onSelect;

  const ReusableCountryPickerFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        style:  GoogleFonts.montserrat(
                  textStyle: const   TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),), // Customize text color
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
        
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle:const  TextStyle(color: Colors.blueGrey),
          prefixIcon: const Icon(
            Icons.flag_outlined,
            color: Colors.blueGrey,
          ),
          suffixIcon:const  Icon(
            Icons.arrow_drop_down,
            color: Colors.blueGrey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        onTap: () {
          showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle:const  TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500,
              borderRadius:const  BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              inputDecoration: InputDecoration(
                
                hintText: 'Select Your Nationality',
                hintStyle:const TextStyle(color: Colors.grey),
                prefixIcon:const  Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            onSelect: onSelect,
          );
        },
      ),
    );
  }
}