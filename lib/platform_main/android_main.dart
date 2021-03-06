import 'package:imc/core/constants/app_colors.dart';
import 'package:imc/presentation/android/views/my_account_screen.dart';
import 'package:imc/presentation/android/views/history_screen.dart';
import 'package:imc/presentation/android/views/form_screen.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AndroidMain extends StatefulWidget {
  const AndroidMain({Key? key}) : super(key: key);

  @override
  _AndroidMainState createState() => _AndroidMainState();
}

class _AndroidMainState extends State<AndroidMain> {
  var _currentScreen = 0;

  final _screens = [
    const AndroidFormScreen(),
    const HistoryScreen(),
    const MyAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.appName,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _screens.elementAt(_currentScreen),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentScreen,
          onTap: (index) => setState(() {
            _currentScreen = index;
          }),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              label: AppStrings.imc,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: AppStrings.history,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: AppStrings.myAccount,
            )
          ],
        ),
      ),
    );
  }
}
