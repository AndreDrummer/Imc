import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/auth/auth_controller.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({
    required this.authController,
    Key? key,
  }) : super(key: key);

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return authController.firebaseUser == null
        ? _unloggedScreen()
        : _loggedScreen();
  }

  Widget _loggedScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.google),
          SizedBox(height: 16.0.h),
          Text(
              '${AppStrings.connectedAs} ${authController.firebaseUser?.displayName.toString()}'),
          SizedBox(height: 16.0.h),
          ElevatedButton(
            onPressed: () {},
            child: const Text(AppStrings.unconnect),
          )
        ],
      ),
    );
  }

  Widget _unloggedScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0.h),
          const Text(
            AppStrings.noAccountConnected,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0.h),
          const Text(
            AppStrings.noAccountConnectedInfo,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0.h),
          ElevatedButton.icon(
            onPressed: () async {
              authController.googleSignIn();
            },
            label: const Text(AppStrings.connect),
            icon: const Icon(FontAwesomeIcons.google),
          )
        ],
      ),
    );
  }
}
