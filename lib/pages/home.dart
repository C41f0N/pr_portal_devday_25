/*
  HOME PAGE
  ---

  Shows tables for attendance and competition timings.
*/

import 'package:flutter/material.dart';
import 'package:pr_portal_devday_25/widgets/mode_switcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool state = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ModeSwitcher(
              width: MediaQuery.of(context).size.width * 0.7,
              thumbColor: Theme.of(context).colorScheme.primary,
              mode: state,
              onChanged: (x) {
                setState(() {
                  state = x;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
