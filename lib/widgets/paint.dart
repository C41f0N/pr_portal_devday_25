import 'package:flutter/material.dart';

class AngledBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    
    // Black base
    paint.color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    
    // First dark red layer
    paint.color = Color.fromARGB(255, 75, 9, 8);
    var path1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width* 0.9, 0)
      ..lineTo(0, size.height * 0.6)
      ..close();
    canvas.drawPath(path1, paint);
    
    // // Second medium red layer
    // paint.color = Color(0xFF8A0000);
    // var path2 = Path()
    //   ..moveTo(0, 0)
    //   ..lineTo(size.width * 0.85, 0)
    //   ..lineTo(size.width * 0.6, size.height * 0.9)
    //   ..lineTo(0, size.height * 0.5)
    //   ..close();
    // canvas.drawPath(path2, paint);
    
    // // Third bright red layer
    // paint.color = Color.fromARGB(255, 101, 0, 0);
    // var path3 = Path()
    //   ..moveTo(0, 0)
    //   ..lineTo(size.width * 0.7, 0)
    //   ..lineTo(size.width * 0.4, size.height * 0.8)
    //   ..lineTo(0, size.height * 0.3)
    //   ..close();
    // canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}