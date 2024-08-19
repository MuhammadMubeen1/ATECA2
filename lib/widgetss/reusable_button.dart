import 'package:employe_portal/color.dart';
import 'package:employe_portal/widgetss/reusable_text.dart';
import 'package:flutter/material.dart';


class ReusableButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final Color buttonColor;

   ReusableButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.buttonColor = const Color(0xff2476BD)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ), backgroundColor: isLoading ? AppColor.btnColor : buttonColor,
        padding: EdgeInsets.zero,
        alignment: Alignment.center
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: isLoading
            ? CircularProgressIndicator(
                color: Color(0xff2476BD),
              )
            : Center(
              child: ReusableText(
                  title: title,
                  size: 16,
                  weight: FontWeight.w900,
                  color: Colors.white,
                ),
            ),
      ),
    );
  }
}
