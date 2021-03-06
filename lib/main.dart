import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:imc/core/auth/auth_controller.dart';
import 'package:imc/core/shared/local_storage.dart';
import 'package:imc/platform_main/android_main.dart';
import 'package:imc/core/bloc/history_cubit.dart';
import 'package:imc/platform_main/ios_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await LocalStorage.initializeLocalStorage();
  await Firebase.initializeApp();
  AuthController.authController.checkSignedIn();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ImcCubit(),
        ),
        BlocProvider(
          create: (_) => IMCHistoryCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: () =>
            Platform.isAndroid ? const AndroidMain() : const IOSMain(),
      ),
    );
  }
}
