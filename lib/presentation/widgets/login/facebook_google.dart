import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacebookGoogleConTainer extends StatelessWidget {
  final String imagePath;
  final Function onClick;

  const FacebookGoogleConTainer({
    this.imagePath,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: screenSize.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Center(
            child: SvgPicture.asset(
              imagePath,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}