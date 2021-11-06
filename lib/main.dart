import 'package:imc/core/bloc/history_cubit.dart';
import 'package:imc/platform_main/android_main.dart';
import 'package:imc/platform_main/ios_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

void main() {
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
      child: Platform.isAndroid ? AndroidMain() : const IOSMain(),
    );
  }
}
