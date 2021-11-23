import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imc/core/auth/auth_controller.dart';
import 'package:imc/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:imc/presentation/android/admob/app_ads.dart';
import 'package:imc/presentation/android/widget/loading_widget.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  AdsManager adsManager = AdsManager();

  @override
  void initState() {
    super.initState();

    adsManager.createBannerAdWithCustomSize();
  }

  @override
  void dispose() {
    adsManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, _) {
        if (AuthController.authController.firebaseUser != null) {
          return _wrapperWidgetAd(
            child: _loggedScreen(
              userLoggedName:
                  AuthController.authController.firebaseUser!.displayName!,
              callbackSignOut: () async =>
                  AuthController.authController.signOut(),
            ),
          );
        } else if (AuthController.authController.firebaseUser == null) {
          return _wrapperWidgetAd(
            child: _unloggedScreen(
              callbackSignIn: () async {
                AuthController.authController.googleSignIn();
              },
            ),
          );
        } else {
          return _wrapperWidgetAd(child: const LoadingWidget());
        }
      },
    );
  }

  Widget _loggedScreen({
    required String userLoggedName,
    required Future Function() callbackSignOut,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.google),
          SizedBox(height: 16.0.h),
          Text('${AppStrings.connectedAs} $userLoggedName'),
          SizedBox(height: 16.0.h),
          ElevatedButton(
            onPressed: () async => callbackSignOut(),
            child: const Text(AppStrings.unconnect),
          )
        ],
      ),
    );
  }

  Widget _unloggedScreen({required Future Function() callbackSignIn}) {
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
            onPressed: () async => callbackSignIn(),
            label: const Text(AppStrings.connect),
            icon: const Icon(FontAwesomeIcons.google),
          )
        ],
      ),
    );
  }

  Widget _wrapperWidgetAd({required Widget child}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: child),
        Container(
          margin: const EdgeInsets.only(bottom: 48.0),
          child: adsManager.adBannerWidgetWithCustomSize(),
        ),
      ],
    );
  }
}
