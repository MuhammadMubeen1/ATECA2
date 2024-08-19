import 'package:flutter/material.dart';

class ReusableDropdown extends StatelessWidget {
  final String? selectedValue;
  final String hint;
  final Icon prefixIcon;
  final Function(String?) onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final void Function()? onSubmitted;

  final List<String> _uaeStates = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah'
  ];

  ReusableDropdown({
    Key? key,
    required this.selectedValue,
    required this.hint,
    required this.prefixIcon,
    required this.onChanged,
    this.validator,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      dropdownColor: Colors.white, // Set your desired dropdown menu color here
      iconEnabledColor: Colors.blue,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
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
      focusNode: focusNode,
      value: selectedValue,
      items: _uaeStates.map((state) {
        return DropdownMenuItem<String>(
          value: state,
          child: Text(
            state,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
