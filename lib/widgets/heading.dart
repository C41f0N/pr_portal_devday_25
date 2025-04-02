import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';

class HeadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(child: Text('Participant', style: textStyle)),
          FittedBox(child: Text('Relations', style: textStyle)),
          FittedBox(child: Text('Portal', style: textStyle)),
        ],
      ),
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 35, // Increased font size
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: CustomColors().lightRed,
  );
}
