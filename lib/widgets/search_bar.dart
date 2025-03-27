import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;

  const CustomSearchBar({super.key, required this.controller});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.only(top: 6,bottom: 6, left: 28, right: 4),
        width: double.infinity,
        height: height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: CustomColors().searchBarGrey,
        ),
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: CustomColors().searchBarText,
            fontSize: 24,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: CustomColors().searchBarText,
              fontSize: 24,
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(right: 8), // Adjust alignment
              child: IconButton(
                icon: Icon(Icons.cancel_rounded, size: 24, color: Colors.white),
                onPressed: () {
                  widget.controller.clear();
                },
              ),
            )
                : null,
          ),
          onChanged: (value) {
            // Trigger UI update when text changes
          },
        ),
      ),
    );
  }
}
