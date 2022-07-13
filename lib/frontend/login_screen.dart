import 'package:desemar_app/backend/functions/dialog_functions.dart';
import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/functions/services_api/auth_services.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:desemar_app/frontend/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0,),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0,),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image.asset(
                        '${GlobalString.imagePath}/logo.png',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          'Username',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text(
                          'Password',
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0,),
                            child: Icon(
                              isObscured ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await AuthServices().loginUser(usernameController.text, passwordController.text).then((dioResult) {
                          if(dioResult) {
                            RouteFunctions(context: context).replaceScreen(const HomeScreen());
                          } else {
                            DialogFunctions(context: context, message: 'Gagal masuk, username & password tidak sesuai, silahkan coba lagi').okDialog(() {

                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: GlobalColor.primary,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0,),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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