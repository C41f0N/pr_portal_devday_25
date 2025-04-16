import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pr_portal_devday_25/constants/colors.dart';
import 'package:pr_portal_devday_25/pages/login_handler.dart';
import 'package:pr_portal_devday_25/widgets/heading.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Future<void> _imagePreload;

  @override
  void initState() {
    super.initState();
    _imagePreload = _preloadImage();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginHandler()),
      );
    });
  }

  Future<void> _preloadImage() async {
    await precacheImage(AssetImage('assets/logo.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _imagePreload,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (snapshot.connectionState == ConnectionState.done)
                  Image.asset(
                    'assets/logo.png',
                    width: width * 0.8,
                    height: height * 0.2,
                  )
                else
                  CircularProgressIndicator(), // Show loading indicator while image is preloading
                SizedBox(height: height * 0.1),
                HeadingWidget(),
                SizedBox(height: height * 0.1),
                LoadingAnimationWidget.progressiveDots(
                  color: CustomColors().lightRed,
                  size: 60,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
