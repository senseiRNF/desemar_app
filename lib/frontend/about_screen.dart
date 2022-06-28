import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tentang Kami',
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0,),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0,),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: Image.asset(
                          '${GlobalString.imagePath}/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        'DESEMAR adalah brand di bawah badan hukum PT DES Teknologi Informasi, sebagai perusahaan yang bergarak di bidang layanan berbasis data, pengembangan infrastuktur jaringan, dan aplikasi dengan bisnis utama jasa layanan internet',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          RouteFunctions(context: context).backOffScreen(null);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: GlobalColor.primary,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0,),
                          child: Text(
                            'OK',
                          ),
                        ),
                      ),
                    ],
                  ),
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