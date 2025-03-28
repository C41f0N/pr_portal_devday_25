import 'package:flutter/material.dart';

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
    fontSize: 60, // Increased font size
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.red,
  );
}
