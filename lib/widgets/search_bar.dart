import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar({
    super.key, 
    required this.controller,
    required this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (mounted) {
        setState(() {});
        try {
          widget.onChanged(widget.controller.text);
        } catch (e) {
          debugPrint('Error in search callback: $e');
        }
      }
    };
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.only(top: 8,bottom: 6, left: 28, right: 4),
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
              padding: EdgeInsets.only(top: 2, right: 8),
              child: IconButton(
                icon: Icon(Icons.cancel_rounded, size: 24, color: CustomColors().searchBarText),
                onPressed: () {
                  widget.controller.clear();
                },
              ),
            )
                : null,
          ),
        ),
      ),
    );
  }
}
