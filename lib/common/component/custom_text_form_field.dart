import 'package:delivery_app/common/const/color.dart';
import 'package:flutter/material.dart';



class CustomTextFormField extends StatelessWidget {
  final String? hinText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    this.hinText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {

    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Input_Border_color,
        width: 1
      ),
    );



    return TextFormField(
      controller: controller,
      cursorColor: Primary_Color,
      obscureText: obscureText,
      autofocus: autofocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hinText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: Body_Text_Color,
          fontSize: 14.0,
        ),
        fillColor: Input_Bg_color,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: Primary_Color,
          ),
        ),
      ),
    );
  }
}
