import 'package:desemar_app/backend/class_data/home_menu_class.dart';
import 'package:desemar_app/backend/functions/route_functions.dart';
import 'package:desemar_app/backend/variables/global.dart';
import 'package:desemar_app/frontend/about_screen.dart';
import 'package:desemar_app/frontend/absence_screen.dart';
import 'package:desemar_app/frontend/payroll_screen.dart';
import 'package:desemar_app/frontend/profile_screen.dart';
import 'package:desemar_app/frontend/splash_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  List<HomeMenuClass> homeMenuClass = [];

  @override
  void initState() {
    super.initState();
    
    setState(() {
      homeMenuClass = [
        HomeMenuClass(
          title: 'Data Karyawan',
          onPress: () {
            RouteFunctions(context: context).moveScreen(const ProfileScreen(), (callback) {

            });
          },
        ),
        HomeMenuClass(
          title: 'Data Gaji',
          onPress: () {
            RouteFunctions(context: context).moveScreen(const PayrollScreen(), (callback) {

            });
          },
        ),
        HomeMenuClass(
          title: 'Absensi',
          onPress: () {
            RouteFunctions(context: context).moveScreen(const AbsenceScreen(), (callback) {

            });
          },
        ),
        HomeMenuClass(
          title: 'Tentang Kami',
          onPress: () {
            RouteFunctions(context: context).moveScreen(const AboutScreen(), (callback) {

            });
          },
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if(result == 'logout') {
                RouteFunctions(context: context).replaceScreen(const SplashScreen());
              }
            },
            itemBuilder: (BuildContext menuContext) => <PopupMenuEntry> [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Aplikasi Penggajian',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'Selamat Beraktivitas, ${name ?? 'User'}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Image.asset(
                    '${GlobalString.imagePath}/home-header.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0,),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0,),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              '${GlobalString.imagePath}/present-icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Hadir',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            '25',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              '${GlobalString.imagePath}/with-permission-icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Izin',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            '2',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              '${GlobalString.imagePath}/sick-icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Sakit',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            '0',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: Image.asset(
                              '${GlobalString.imagePath}/absent-icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Absen',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            '3',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: homeMenuClass.length,
                itemBuilder: (BuildContext menuContext, int index) {
                  return Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => homeMenuClass[index].onPress(),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0,),
                      ),
                      child: Center(
                        child: Text(
                          homeMenuClass[index].title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}