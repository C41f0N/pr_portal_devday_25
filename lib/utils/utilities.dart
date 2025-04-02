import 'package:flutter/widgets.dart';

bool isHorizontal(BuildContext context) {
  return MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
}
