import 'package:employe_portal/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class ReusableTextForm2 extends StatelessWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validator;
  final Widget prefixIcon;

  ReusableTextForm2({
    required this.focusNode,
    required this.onSubmitted,
    required this.keyboardType,
    required this.textCapitalization,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      controller: controller,
     
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.whiteColor,
    
        prefixIcon: prefixIcon,
      
        hintText: hintText,
        hintStyle:const  TextStyle(color: AppColor.hintColor, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColor.borderFormColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide:const  BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide:const  BorderSide(color: AppColor.borderFormColor, width: 1),
        ),
      ),
      validator: validator,
      inputFormatters: [
        LowerCaseTextFormatter(),
      ],
    );
  }
}
