import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/core/bloc/imc_cubit.dart';
import 'package:imc/views/android_main.dart';
import 'package:imc/views/ios_main.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImcCubit(),
      child: Platform.isAndroid ? const AndroidMain() : const IOSMain(),
    );
  }
}
