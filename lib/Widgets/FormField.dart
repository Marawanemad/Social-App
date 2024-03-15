import 'package:flutter/material.dart';

// to make text form field to reuse it
formField({
  required TextEditingController controller,
  String? labelText,
  String? hentText,
  Icon? prefixicon,
  IconData? suffixicon,
  suffixpressed,
  bool? obscureText,
  required TextInputType keyboardtype,
  String? validiationMesseage,
  TextInputAction? text_input_action,
  onsubmit(value)?,
  bool boxShape = false,
  bool NoShape = false,
  double circularBorder = 8,
  Color? prefixIconColor,
  Color? suffixiconColor,
  Color? BorderColor,
  padding,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: TextFormField(
      maxLines: keyboardtype == TextInputType.multiline ? null : 1,
      obscureText: obscureText ?? false,
      controller: controller,
      // to make action when click on keyboard submit
      textInputAction: text_input_action,
      decoration: InputDecoration(
        prefix: SizedBox(width: 10),
        // text appear in box and when you pressed on it move to up and donot disappear
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        // word appear when presed on box and disappeared when user write
        hintText: hentText,
        // to put icon in the start of box
        prefixIcon: prefixicon,
        prefixIconColor: prefixIconColor ?? Colors.black,
        suffixIcon: Padding(
          padding: padding ?? EdgeInsets.all(0),
          child: IconButton(
              onPressed: suffixpressed,
              icon: Icon(
                suffixicon,
                color: suffixiconColor ?? Colors.black,
              )),
        ),
        // use to put  line under TextFormField and change the colors
        enabledBorder:
            // to check if you donot want any shape or not
            NoShape
                ? InputBorder.none
                // to check if you want this shape only line or box
                : boxShape
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(circularBorder),
                        borderSide:
                            BorderSide(color: BorderColor ?? Colors.cyan))
                    : UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: BorderColor ?? Colors.cyan)),
        // use to change color of the TextFormField we selected only
        focusedBorder: NoShape
            ? InputBorder.none
            : boxShape
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(circularBorder),
                    borderSide: BorderSide(color: BorderColor ?? Colors.cyan))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: BorderColor ?? Colors.cyan)),
      ),
      cursorColor: Colors.cyan,
      keyboardType: keyboardtype,
      onFieldSubmitted: onsubmit,
      // make validator to check empty
      validator: (String? value) {
        if (value!.isEmpty) {
          return validiationMesseage;
        }
        return null;
      },
    ),
  );
}
