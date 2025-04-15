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

    return TextField(
      controller: widget.controller,
      style: TextStyle(color: CustomColors().searchBarText),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          gapPadding: 900,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          gapPadding: 900,
        ),
        hintText: 'Search',
        filled: true,
        fillColor: CustomColors().searchBarGrey,
        hintStyle: TextStyle(color: CustomColors().searchBarText),
        suffixIcon: Icon(Icons.search, color: CustomColors().searchBarText),
      ),
    );
  }
}
