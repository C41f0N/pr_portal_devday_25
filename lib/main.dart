import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/models/pr_portal.dart';
import 'package:pr_portal_devday_25/pages/login_handler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("LOCAL_STORAGE");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PRPortal(),
      builder: (context, widget1) {
        Color primaryColor = const Color.fromARGB(255, 175, 40, 43);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Participant Relations Portal',
          theme: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: primaryColor,
              surface: CustomColors().darkRed,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: const Color.fromARGB(
                255,
                13,
                13,
                13,
              ).withValues(alpha: 0.9),
            ),
          ),
          home: const LoginHandler(),
        );
      },
    );
  }
}
