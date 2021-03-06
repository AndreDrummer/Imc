import 'package:imc/core/constants/app_strings.dart';
import 'package:imc/presentation/ios/form_screen.dart';
import 'package:flutter/cupertino.dart';

class IOSMain extends StatelessWidget {
  const IOSMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text(AppStrings.appName),
          backgroundColor: CupertinoTheme.of(context).primaryColor,
        ),
        child: const IosFormScreen(),
      ),
    );
  }
}
