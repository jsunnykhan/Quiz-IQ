import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final Function onValidator;
  final Function onSaved;
  final String labelText;

  const CustomEditText({
    this.onValidator,
    this.onSaved,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidator,
      onSaved: onSaved,
      decoration: InputDecoration(
        fillColor: Colors.white12,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: new BorderRadius.circular(5.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: new BorderRadius.circular(5.7),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
