import 'package:employe_portal/color.dart';
import 'package:flutter/material.dart';



class ReusableTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? hintStyle;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Color filledColor;
  final Widget? prefixIcon;
  final String? errorText;
  final int maxLines;
  final int minLines;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const ReusableTextForm({
    Key? key,
    this.validator,
    this.errorText,
    this.controller,
    this.hintStyle,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.filledColor = AppColor.transparentColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    this.focusNode,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      onChanged: onChange,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
         contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0), 
        filled: true,
        fillColor: AppColor.whiteColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabled: enabled,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.hintColor, fontSize: 14),
       
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
          borderSide:const BorderSide(color: AppColor.borderFormColor, width: 1),
        ),
      ),
      validator: validator,
    );
  }
}
