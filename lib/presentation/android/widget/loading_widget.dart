import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:imc/core/constants/app_strings.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.textMessage = AppStrings.gettingRegisterData,
    Key? key,
  }) : super(key: key);

  final String textMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textMessage),
          SizedBox(height: 16.0.h),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
