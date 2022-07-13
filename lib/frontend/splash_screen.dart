import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/functions/shared_preferences.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:desemar_app/frontend/home_screen.dart';
import 'package:desemar_app/frontend/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((result) {
      if(result != null) {
        Future.delayed(const Duration(seconds: 2), () {
          RouteFunctions(context: context).replaceScreen(const HomeScreen());
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          RouteFunctions(context: context).replaceScreen(const LoginScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Image.asset(
                    '${GlobalString.imagePath}/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}