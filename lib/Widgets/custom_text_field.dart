import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {super.key,
      this.hint,
      required this.label,
      required this.fontcolor,
      this.onchange,
      this.onsubmit,
      this.action = TextInputAction.next,this.obscuretext=false});
  String? hint;
  String? label;
  Color? fontcolor;
  Function(String)? onchange;
  Function(String)? onsubmit;
  TextInputAction? action;
  bool? obscuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext!,
      validator: (data) {
        if (data!.isEmpty) {
          return "Field is required";
        }
      },
      textInputAction: action,
      onChanged: onchange,
      onFieldSubmitted: onsubmit,
      style: TextStyle(color: fontcolor, fontSize: 18),
      decoration: InputDecoration(
          label: Text(
            "$label",
            style: TextStyle(color: fontcolor),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          )),
    );
  }
}
