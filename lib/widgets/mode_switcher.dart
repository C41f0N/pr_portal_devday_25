/*
  Mode Switcher
  ---

  A switch to toggle between the Attendance and Competitions mode.
*/

import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';

class ModeSwitcher extends StatefulWidget {
  const ModeSwitcher({
    super.key,
    required this.width,
    required this.thumbColor,
    required this.mode,
    required this.onChanged,
  });

  final double width;
  final Color thumbColor;
  // true for Attendance, false for Competitions
  final bool mode;
  final Function(bool) onChanged;

  @override
  State<ModeSwitcher> createState() => _ModeSwitcherState();
}

class _ModeSwitcherState extends State<ModeSwitcher> {
  Offset position = Offset(0, 0);
  Offset initialPosition = Offset(0, 0);
  double thumbRatio = 0.75;

  double drag = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            widget.onChanged(!widget.mode);
          },

          onHorizontalDragStart: (DragStartDetails details) {
            initialPosition = details.localPosition;
          },

          onHorizontalDragUpdate: (DragUpdateDetails details) {
            setState(() {
              drag = details.localPosition.dx - initialPosition.dx;

              if (widget.mode && drag < 0) {
                drag = 0;
              } else if (!widget.mode && drag > 0) {
                drag = 0;
              } else {
                if (drag > widget.width * (1 - thumbRatio)) {
                  drag = widget.width * (1 - thumbRatio);
                } else if (drag < -widget.width * (1 - thumbRatio)) {
                  drag = -widget.width * (1 - thumbRatio);
                }
              }
            });
          },

          onHorizontalDragEnd: (DragEndDetails details) {
            if (widget.mode && drag < 0) {
              setState(() {
                drag = 0;
              });
            } else if (!widget.mode && drag > 0) {
              setState(() {
                drag = 0;
              });
            } else if (drag.abs() > widget.width * (1 - thumbRatio) / 2) {
              setState(() {
                drag = 0;
              });
              widget.onChanged(!widget.mode);
            } else {
              setState(() {
                drag = 0;
              });
            }
          },

          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(90),
                ),
                width: widget.width,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.width * (1 - thumbRatio) * 1 / 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
                          Transform.translate(
                            offset: Offset(10, 0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Transform.rotate(
                        angle: pi,
                        child: Stack(
                          children: [
                            Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
                            Transform.translate(
                              offset: Offset(10, 0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastEaseInToSlowEaseOut,
                transform: Matrix4.translation(
                  math.Vector3(
                    widget.mode
                        ? -widget.width * (1 - thumbRatio) / 2 + drag.abs()
                        : widget.width * (1 - thumbRatio) / 2 + -drag.abs(),
                    0,
                    0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: widget.thumbColor,
                  borderRadius: BorderRadius.circular(90),
                ),
                alignment: Alignment.center,
                width: widget.width * thumbRatio,
                height: 50,
                child: Text(
                  widget.mode ? "Attendance" : "Competitions",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
