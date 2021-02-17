import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final screenSize;

  const LoginHeader({this.screenSize});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.08),
        Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        Text(
          'Access account',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
       
      ],
    );
  }
}
